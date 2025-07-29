terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.5.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

data "aws_ami" "name" {
    most_recent = true
    owners = ["amazon"]

  
}

data "aws_vpc" "name" {
    tags = {
      Name = "my_vpc"
    }
  
}

output "aws_ami" {
    value = data.aws_ami.name.id
  
}

resource "aws_instance" "myserver" {
    ami = "ami-0d0ad8bb301edb745"
    instance_type = "t2.micro"
    subnet_id = data.aws_subnet.name.id
    security_groups = [data.aws_security_group.name.id]

    tags = {
        Name = "SampleServer"
    }
  
}

data "aws_security_group" "name" {
    tags = {
      mywebser = "http"
    }
  
}
output "name" {
    value = data.aws_security_group.name
  
}

data "aws_subnet" "name" {
    filter {
      name = "vpc-id"
      values = [data.aws_vpc.name.id]
    }
    tags = {
      Name = "private-subnet"
    }
}