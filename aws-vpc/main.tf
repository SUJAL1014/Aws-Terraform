terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.5.0"
    }
  }
}

provider "aws" {
    region = "ap-south-1"  
}

#Create a VPC 
resource "aws_vpc" "my-vpc" {
    cidr_block = "10.0.0.0/16"
    tags = {
        Name = "my-vpc-tf"
    }
}

#Private Subnet
resource "aws_subnet" "private-subnet" {
    cidr_block = "10.0.1.0/24"
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      Name = "private-subnet-tf"
    }
  
}
data "aws_availability_zones" "available" {}

#Public Subnet
resource "aws_subnet" "public-subnet" {
    cidr_block = "10.0.2.0/24"
    vpc_id = aws_vpc.my-vpc.id
    availability_zone = data.aws_availability_zones.available.names[0]

    tags = {
      Name = "public-subnet-tf"
    }
  
}

#Internet Gateway
resource "aws_internet_gateway" "my-igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
        Name = "my-igw-tf"
    }
  
}

#Route Table 
resource "aws_route_table" "my-rt" {
    vpc_id = aws_vpc.my-vpc.id
    tags ={
        Name = "my-rt-tf"
    }

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my-igw.id

    }
}

resource "aws_route_table_association" "public-sub" {
    route_table_id = aws_route_table.my-rt.id
    subnet_id =aws_subnet.public-subnet.id
}

resource "aws_instance" "myserver" {
    ami = "ami-0d0ad8bb301edb745"
    instance_type = "t2.nano"
    subnet_id = aws_subnet.public-subnet.id 
      
    
    tags = {
        Name = "mywebserver-vpc-tf"
    }
  
}