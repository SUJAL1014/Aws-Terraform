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
  region = var.region
}

resource "aws_instance" "myserver" {
    ami = "ami-0d0ad8bb301edb745"
    instance_type = "t2.nano"

    tags = {
        Name = "SampleServer"
    }
  
}