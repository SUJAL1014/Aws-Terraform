
# EC2 instance For Nginx setup
resource "aws_instance" "nginxserver" {
  ami                         = "ami-0d0ad8bb301edb745"
  instance_type               = "t3.nano"
  subnet_id                   = aws_subnet.public-subnet.id
  

  tags = {
    Name = "NginxServer"
  }
}