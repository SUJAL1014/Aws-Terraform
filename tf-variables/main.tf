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

resource "aws_instance" "myserver" {
  ami           = "ami-0d0ad8bb301edb745"
  instance_type = var.aws_instance_type

  root_block_device {
    delete_on_termination = true
    volume_size           = var.ec2_config.v_size
    volume_type           = var.ec2_config.v_type              
  }

  tags = merge(var.additonal_tags, {
    Name = local.Name
  })
}

locals {
  Name = "Myserver"
  Owner = "John Doe"
}
