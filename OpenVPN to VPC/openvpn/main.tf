# Generates a secure private key and encodes it as PEM
resource "tls_private_key" "key_pair" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Create the Key Pair
resource "aws_key_pair" "key_pair" {
  key_name   = var.private_key_pair_name
  public_key = tls_private_key.key_pair.public_key_openssh
}

# Save file
resource "local_file" "ssh_key" {
  count           = var.save_local ? 1 : 0
  filename        = "${aws_key_pair.key_pair.key_name}.pem"
  content         = tls_private_key.key_pair.private_key_pem
  file_permission = "0400"
}

resource "aws_secretsmanager_secret" "ssh_key_secret" {
  count       = var.save_to_cloud ? 1 : 0
  name        = "${aws_key_pair.key_pair.key_name}.pem"
  description = "Open VPN secret pem"
}

resource "aws_secretsmanager_secret_version" "ssh_key_content" {
  count         = var.save_to_cloud ? 1 : 0
  secret_id     = aws_secretsmanager_secret.ssh_key_secret[0].id
  secret_string = tls_private_key.key_pair.private_key_pem
}

# Define security group
resource "aws_security_group" "openvpn_sg" {
  name        = var.sg_name
  description = "Open vpn security group"
  vpc_id      = var.vpc_id

  tags = {
    Name = var.sg_name
  }
}

resource "aws_security_group_rule" "allow_outbound" {
  type              = "egress"
  to_port           = 0
  protocol          = "-1"
  from_port         = 0
  cidr_blocks       = ["0.0.0.0/0"]
  ipv6_cidr_blocks  = ["::/0"]
  security_group_id = aws_security_group.openvpn_sg.id

  description = "Allow outbound access to the world"
}

resource "aws_security_group_rule" "allow_inbound_to_all" {
  count             = var.allow_access_to_all ? 1 : 0
  type              = "ingress"
  from_port         = 1194
  to_port           = 1194
  protocol          = "udp"
  security_group_id = aws_security_group.openvpn_sg.id
  cidr_blocks       = var.allow_openvpn_connect
}

data "http" "myip" {
  count = var.allow_access_to_self ? 1 : 0
  url   = "http://ipv4.icanhazip.com"
}

# resource "aws_security_group_rule" "allow_inbound_to_self" {
#   count             = var.allow_access_to_self ? 1 : 0
#   type              = "ingress"
#   from_port         = 1194
#   to_port           = 1194
#   protocol          = "udp"
#   security_group_id = aws_security_group.openvpn_sg.id
#   cidr_blocks       = ["94.188.186.150/32"]

# }

resource "aws_security_group_rule" "allow_openvpn_dashboard" {
  count             = var.allow_access_to_self ? 1 : 0
  type              = "ingress"
  from_port         = 80
  to_port           = 80
  protocol          = "tcp"
  security_group_id = aws_security_group.openvpn_sg.id
  cidr_blocks       = var.allow_openvpn_admin_access

}

resource "aws_security_group_rule" "configuration_port" {
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  security_group_id = aws_security_group.openvpn_sg.id
  cidr_blocks       = var.allow_openvpn_admin_access

}

# Fetch AMI
data "aws_ami" "ubuntu_latest" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-20231004"]
  }
}

resource "aws_instance" "openvpn" {
  ami                    = data.aws_ami.ubuntu_latest.id
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.openvpn_sg.id]
  key_name               = aws_key_pair.key_pair.key_name
  ebs_optimized          = true
  iam_instance_profile   = aws_iam_instance_profile.ssm_profile.name

  root_block_device {
    volume_type = "gp3"
    encrypted   = true
    tags = {
      Name = var.instance_name
      DevopsName  = "Shimon"
    }
  }


  tags = {
    Name = var.instance_name
    DevopsName  = "Shimon"
  }
}

resource "terraform_data" "install_openvpn" {
  triggers_replace = [
    aws_instance.openvpn.id,
  ]
  connection {
    type        = "ssh"
    host        = aws_eip.open_vpn_ip.public_ip
    user        = "ubuntu"
    private_key = tls_private_key.key_pair.private_key_pem
  }
  provisioner "local-exec" {
    command = "aws ec2 wait instance-status-ok --instance-ids ${aws_instance.openvpn.id} --profile ${var.profile} --region ${var.region}"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo curl -O https://raw.githubusercontent.com/angristan/openvpn-install/master/openvpn-install.sh",
      "sudo chmod +x openvpn-install.sh",
      # "printf '${aws_eip.open_vpn_ip.public_ip}\nn\n1\n1\n1\nn\nn\n\n${var.open_vpn_starting_user}\n1\n'"
      "echo pwd",
      "printf '${aws_eip.open_vpn_ip.public_ip}\nn\n1\n1\n9\nn\nn\n\n${var.open_vpn_starting_user}\n1\n' | sudo ./openvpn-install.sh",
      "echo management 127.0.0.1 5555 | sudo tee -a /etc/openvpn/server.conf",
      "sudo systemctl restart openvpn@server.service",
      "sudo apt update -y",
      "sudo apt install -y python3-pip",
      "sudo apt install -y gunicorn",
      "sudo pip install openvpn-monitor ",
      "sudo mkdir /opt/openvpn-monitor",
      <<EOF
      cat <<EOT | sudo tee /opt/openvpn-monitor/openvpn-monitor.conf
[openvpn-monitor]
site=your-openvpn-site
#logo=logo.jpg
#latitude=40.72
#longitude=-74
maps=True
geoip_data=/var/lib/GeoIP/GeoLite2-City.mmdb
datetime_format=%d/%m/%Y %H:%M:%S

[VPN1]
host=localhost
port=
name=${var.instance_name}
show_disconnect=False
EOT
EOF
      ,
      "sudo gunicorn openvpn-monitor -b 0.0.0.0:80 --name openvpn-monitor --daemon"


    ]
  }
}

resource "aws_eip" "open_vpn_ip" {
  instance = aws_instance.openvpn.id
}

resource "aws_iam_role" "ssm_role" {
  name                = "ssm-role-ec2-${var.instance_name}"
  # managed_policy_arns = [data.aws_iam_policy.ssm.arn]
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.ssm_role.name
  policy_arn = data.aws_iam_policy.ssm.arn
}
data "aws_iam_policy" "ssm" {
  name = "AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm_profile" {
  name = "ssm_profile_${var.instance_name}"
  role = aws_iam_role.ssm_role.name
}