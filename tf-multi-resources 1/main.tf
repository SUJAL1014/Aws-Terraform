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

locals {
  project = "project-01"

}

resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags ={
        Name = "${local.project}-vpc"
    }
}

resource "aws_subnet" "main" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = "10.0.${count.index}.0/24" 
    count = 2
    tags = {
      Name = "${local.project}-subnet-${count.index}"
    }
}

#Creating 4ec2 instances
resource "aws_instance" "main" {
    ami = "ami-0d0ad8bb301edb745"
    instance_type = "t3.micro"
    count = 4
    subnet_id = element(aws_subnet.main[*].id, count.index % length(aws_subnet.main))

    tags = {
        Name = "${local.project}-ec2-${count.index}"
    }
}

output "name" {
    value = aws_subnet.main[1].id
  
}