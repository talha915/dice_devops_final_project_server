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

  tags = {
    Name = "server-ec2-instance"
  }

  provisioner "remote-exec" {
    
    connection {
      type        = "ssh"
      user        = "ubuntu"  # Use the appropriate username for your AMI
      private_key = file("C:/Users/Talha Zafar/Downloads/dice_devops_ec2_key_pairs.pem")  # Path to your private key
      host        = self.public_ip
    }

    # inline = [
    #   "sudo apt-get update",
    #   "sudo apt-get install -y docker.io",
    #   "sudo systemctl start docker",
    #   "sudo systemctl enable docker"
    #   # Additional Docker setup commands if needed
    # ]
  }
}

output "instance_public_ip" {
  value = aws_instance.server.public_ip
}
