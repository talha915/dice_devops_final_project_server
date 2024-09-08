provider "aws" {
  region = "eu-central-1"  # AWS region
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket         = "test-terraform-lock"
    key            = "vpc/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "terraform-locks"
  }
}

resource "aws_instance" "server" {
  ami           = "ami-04f76ebf53292ef4d" 
  instance_type = "t2.micro"
  key_name      = "dice_devops_ec2_key_pairs"

  subnet_id     = data.terraform_remote_state.vpc.outputs.server_subnet_id
  security_groups = [data.terraform_remote_state.vpc.outputs.sg_id]

  associate_public_ip_address = true

  tags = {
    Name = "server-ec2-instance"
  }

}

output "instance_public_ip" {
  value = aws_instance.server.public_ip
}
