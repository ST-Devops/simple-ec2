terraform {
  cloud {
    organization = "st-learn-devops"
    workspaces {
      name = "simple-ec2"
    }
  }
}

provider "aws" {
  region = "ap-south-1"
}

module "vpc" {
  source = "./modules/vpc"

  vpc_cidr    = "10.0.0.0/16"
  subnet_cidr = "10.0.1.0/24"
}

module "ec2" {
  source = "./modules/ec2"

  ami           = "ami-0f58b397bc5c1f2e8"
  instance_type = "t3.micro"

  # 🔥 passing output from vpc module
  subnet_id = module.vpc.subnet_id
}