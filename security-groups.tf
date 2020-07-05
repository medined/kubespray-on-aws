
#
# Ingress
#

resource "aws_security_group" "centos_allow_ssh" {
  name        = "centos_allow_ssh"
  description = "Allow SSH"
  vpc_id      = var.vpc_id

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [ var.ssh_cidr_block ]
  }

  tags = {
    Name = "centos_allow_ssh"
  }
}

#
# Egress
#
resource "aws_security_group" "centos_allow_any_outbound" {
  name        = "centos_allow_any_outbound"
  description = "Centos Allow Any Outbound"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "centos_allow_any_outbound"
  }
}
