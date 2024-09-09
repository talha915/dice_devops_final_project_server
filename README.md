# Project Overview

This repository contains the setup and deployment instructions for a server-client application using Docker, Docker Compose, AWS EC2, and Terraform.

## Base Image and Dockerfile

1. **Choose a Base Image:**
   - Selected an appropriate base image from the [Official Docker Images list](https://hub.docker.com/search?q=&type=image).

2. **Create Dockerfile for Server Container:**
   - Created a `Dockerfile` for the server container with the following specifications:
     - Used a volume named `servervol` and mounted it at `/serverdata` in the container.
     - Installed necessary packages and dependencies required for the server application.
     - Written a server application using FastAPI which:
       - Creates a 1KB file with random text data in the `/serverdata` directory.
       - Sends the file and its checksum to the client.

3. **Docker Compose for Server Container:**
   - Defined and ran the server container using Docker Compose.

4. **Docker Compose for Client Container:**
   - Created a Docker Compose configuration for the client container which:
     - Saves the received file in the `/clientdata` directory.
     - Verifies the file's integrity by checking the received checksum.

## AWS EC2 Instances

1. **Create EC2 Instances:**
   - Created two AWS EC2 instances (VMs):
     - One for hosting the server container.
     - Another for hosting the client container.
   - Used the `t2.micro` instance type, which is covered under the AWS free tier.

2. **Configure Networking:**
   - Configured the VPC and subnets to allow communication between the two EC2 instances.

3. **Terraform Automation:**
   - Used Terraform for infrastructure automation to create and manage the EC2 instances and networking configuration.

## CI/CD Pipelines

1. **Git Repositories:**
   - Created two separate Git repositories for the server and client codebases.

2. **CI/CD Pipelines Setup:**
   - Set up CI/CD pipelines for both repositories:
     - Pushed Docker images to a public registry (Docker Hub).
     - Configured the corresponding VMs as private Git runners.
     - Updated the image tag in Docker Compose, pulled the new image, and deployed it as part of the Continuous Deployment (CD) process.

3. **Email Notifications:**
   - Integrated email notifications for build and deployment statuses.

## Requirements

1. **Server Application:**
   - The server application is developed using FastAPI and requires the following dependencies:
     - Listed in `requirements.txt`.

2. **Installation and Setup:**
   - Follow the instructions in the respective repository for detailed setup and installation steps.

## Usage

- To run the server and client containers, use Docker Compose commands as defined in the `docker-compose.yml` files.
- Ensure that AWS EC2 instances are properly configured and can communicate with each other.
- Check the CI/CD pipeline logs for build and deployment statuses.

## Notes

- Ensure that your AWS credentials and Terraform configuration are set up correctly for seamless infrastructure provisioning.
- Update the Docker images in the registry as needed and reflect changes in the Docker Compose configurations.

