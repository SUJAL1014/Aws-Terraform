terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.5.0"
    }
    random = {
      source = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

resource "aws_s3_bucket_website_configuration" "mywebapp" {
  bucket = aws_s3_bucket.mywebapp-bucket.id

  index_document {
    suffix = "index.html"
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

resource "random_id" "rand_id" {
    byte_length = 8
  
}

resource "aws_s3_bucket" "mywebapp-bucket" {
    bucket = "mywesite-tf-${random_id.rand_id.hex}"
  
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.mywebapp-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "mywebapp" {
    bucket = aws_s3_bucket.mywebapp-bucket.id
    policy = jsonencode(
        {
    Version = "2012-10-17",
    Statement = [
        {
            Sid = "PublicReadGetObject",
            Effect = "Allow",
            Principal = "*",
            Action =  "s3:GetObject",
            Resource = "arn:aws:s3:::${aws_s3_bucket.mywebapp-bucket.id}/*"
        }
    ]
}
    )
}

resource "aws_s3_object" "index_html" {
    bucket = aws_s3_bucket.mywebapp-bucket.bucket
    source = "./index.html"
    key = "index.html"
    content_type = "text/html"
}

resource "aws_s3_object" "style_css" {
    bucket = aws_s3_bucket.mywebapp-bucket.bucket
    source = "./style.css"
    key = "style.css"
    content_type = "text/css"
}

output "name" {
    value = aws_s3_bucket_website_configuration.mywebapp.website_endpoint
  
}