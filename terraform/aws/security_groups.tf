resource "aws_security_group" "ssh" {
  name        = "ex415_ssh"
  description = "SSH Access"
  vpc_id      = var.aws_vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    description = "SSH Access"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    description = "Allow All"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "http" {
  name        = "ex415_http"
  description = "HTTP Access"
  vpc_id      = var.aws_vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    description = "HTTP Access"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_security_group" "https" {
  name        = "ex415_https"
  description = "HTTPS Access"
  vpc_id      = var.aws_vpc_id

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    description = "HTTPS Access"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
