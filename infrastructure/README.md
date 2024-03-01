# Terraform AWS Setup

This repository contains Terraform scripts to set up AWS resources. Follow the steps below to deploy the infrastructure.

## Prerequisites

- [Terraform](https://www.terraform.io/)
- AWS account and IAM user with necessary permissions
- AWS CLI configured with the IAM user credentials
## Steps

### 1. Create S3 Bucket and DynamoDB Table

Create an S3 bucket named `terraform-remote-state-smile-dev` and a DynamoDB table named `terraform-remote-state-lock` for state file locking.

### 2. Update Variables

Update UsernameArn Variable within infrastructure\terragrunt\dev with your local aws account admin user.


### 3. Log in to AWS Console

Log in to the AWS Management Console using your AWS account credentials.

### 4. Navigate to Amazon ECR

Navigate to the Amazon ECR service by clicking on "Services" in the top left corner, searching for "ECR," and selecting it from the results.

### 5. Create a New Repository

- Click on the "Repositories" in the left sidebar.
- Click the "Create repository" button.
- Enter the repository name as 'smile'.
- Optionally, provide a meaningful repository description.
- Click the "Create repository" button.

### 6. Authenticate Docker to ECR

Run the following command in your terminal to authenticate Docker to the ECR registry:

```bash
aws ecr get-login-password --region <your-region> | docker login --username AWS --password-stdin <your-account-id>.dkr.ecr.<your-region>.amazonaws.com
```
### 7. Tag and Push Docker Image to AWS

Run the following command in your terminal to Build the previously created [Link text](https://github.com/3daniel1996/SmileTechnical/blob/main/app/README.md 'Image'):

```bash
docker tag <your-image-name>:latest <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/smile:latest

docker push <your-account-id>.dkr.ecr.<your-region>.amazonaws.com/smile:latest
```

### Run Terraform commands
```bash
cd /infrastructure/terragrunt/dev
terragrunt init
terragrunt apply
```