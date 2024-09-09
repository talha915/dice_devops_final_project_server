# Project Overview
This project demonstrates how to set up a server infrastructure using Terraform, deploy a Dockerized Python Fast application, and manage CI/CD workflows with GitHub Actions.

# Project Components
1. Terraform: Used to define and create AWS infrastructure including EC2 instances, VPCs, and state management with S3 and DynamoDB.
2. Docker: Utilized to containerize the Python Flask application for consistent deployment.
3. GitHub Actions: Configured to automate the CI/CD pipeline, handling the deployment of infrastructure and application updates.

# Infrastructure Setup with Terraform
Description
- EC2 Instance: Provisioned to host the server application.
- VPC: Configured to enable secure communication between the server and client EC2 instances.
- S3 Bucket: Used to lock the Terraform state files for consistency.
- DynamoDB Table: Provides locking for Terraform state to prevent concurrent modifications.

# Configuration
Terraform files are located in the terraform/server directory. The setup involves defining resources such as EC2 instances, VPCs, and state management mechanisms.

## Key Terraform Commands
- terraform init: Initializes the Terraform configuration.
- terraform apply -auto-approve: Applies the configuration to create the infrastructure.

# Application Deployment with Docker
## Description
The server application is developed in Python using Fast and is containerized using Docker. This approach ensures a consistent runtime environment and simplifies deployment.

# Docker Setup
- Dockerfile: Defines the image used to build the server container.
- Docker Compose: Used to define and manage multi-container Docker applications (if applicable).

# CI/CD with GitHub Actions
## Description
GitHub Actions is used to automate the CI/CD process. The workflow is defined in .github/workflows/ci-cd.yml and includes steps to:
- Set up Terraform: Initialize and apply the Terraform configuration to create/update infrastructure.
- Fetch Terraform Outputs: Retrieve outputs like the public IP of the EC2 instance.
- Deploy Docker Container: Build and run the Docker container based on the latest code.

# Workflow

## Terraform Actions:

- Initialize the Terraform configuration.
- Apply changes to create or update infrastructure.
- Fetch the output values such as the public IP address.

# Docker Actions:
- Build Docker images.
- Deploy the Docker container with the updated application code.

# CI/CD Pipeline:

GitHub Actions will automatically handle the CI/CD pipeline. The configuration is located in .github/workflows/ci-cd.yml. Ensure that your GitHub repository is set up with the appropriate secrets and permissions for AWS and Docker.

# Conclusion
This project showcases a complete workflow from infrastructure provisioning using Terraform to application deployment with Docker, all managed through GitHub Actions for CI/CD.
