data "terraform_remote_state" "vpc" {
  backend = "s3"

  config = {
    bucket = "terraform-project-state-file"
    key    = "terraform/network/network.tfstate"
    region = "us-east-1"
  }
}

data "http" "my_ip" {
  url = "http://checkip.amazonaws.com/"
}

data "aws_ami" "amzlinux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["al2023-ami-2023.5.20240916.0-kernel-6.1-x86_64"]
  }
  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

}


