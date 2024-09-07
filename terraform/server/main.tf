provider "aws" {
  region = "eu-central-1"
}

# Use local file to access VPC outputs
data "terraform_output" "vpc" {
  config = {
    path = "../vpc/terraform.tfstate"  # Path to VPC state file
  }
}

resource "aws_instance" "server" {
  ami           = "ami-04f76ebf53292ef4d" 
  instance_type = "t2.micro"
  key_name       = "dice_devops_ec2_key_pairs" 

  subnet_id     = data.terraform_output.vpc.subnet_id.id
  security_groups = [data.terraform_output.vpc.sg_id]

  tags = {
    Name = "server-ec2-instance"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo apt-get update",
      "sudo apt-get install -y docker.io",
      "sudo systemctl start docker",
      "sudo systemctl enable docker"  # Replace with your Docker image
    ]
  }

}
