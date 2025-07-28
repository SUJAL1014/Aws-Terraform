output "aws_instance_public_ip" {
    description = "Public IP of the Nginx EC2 instance"
    value = aws_instance.nginxserver.public_ip
  
}

output "instance_url" {
    description = "URL to access the Nginx server"
    value = "http://${aws_instance.nginxserver.public_ip}"
  
}