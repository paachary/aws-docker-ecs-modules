#!/bin/sh

# Build the container
docker build . -t REPLACE_ME_AWS_ACCOUNT_ID.dkr.ecr.REPLACE_ME_REGION.amazonaws.com/blogapplication/service:latest

# Test the service locally
docker run -p 8000:8000 REPLACE_ME_WITH_DOCKER_IMAGE_TAG

# Create the ECR repostiory
aws ecr create-repository --repository-name blogapplication/service

# Login to the ecr
(aws ecr get-login --no-include-email)

# Push the ecr 
docker push REPLACE_ME_WITH_DOCKER_IMAGE_TAG

# Describe images
aws ecr describe-images --repository-name blogapplication/service

