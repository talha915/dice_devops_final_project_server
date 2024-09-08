terraform {
  backend "s3" {
    bucket         = "test-terraform-lock"  # Manually created S3 bucket name
    key            = "vpc/terraform.tfstate" # Path within the bucket
    region         = "eu-central-1"          # AWS region
    dynamodb_table = "terraform-locks"        # Manually created DynamoDB table name
  }
}
