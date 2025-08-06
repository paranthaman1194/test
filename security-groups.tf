# Web Tier Security Group
resource "aws_security_group" "web" {
  name_prefix = "ecommerce-web-"
  vpc_id      = aws_vpc.main.id
  description = "Security group for web tier"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTP"
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "HTTPS"
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All outbound traffic"
  }

  tags = {
    Name = "ecommerce-web-sg"
  }
}

# Database Security Group
resource "aws_security_group" "database" {
  name_prefix = "ecommerce-db-"
  vpc_id      = aws_vpc.main.id
  description = "Security group for database tier"

  ingress {
    from_port       = 5432
    to_port         = 5432
    protocol        = "tcp"
    security_groups = [aws_security_group.web.id]
    description     = "PostgreSQL from web tier"
  }

  tags = {
    Name = "ecommerce-db-sg"
  }
}