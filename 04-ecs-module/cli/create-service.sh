#!/bin/sh

# Create A Service Linked Role For ECS
aws iam create-service-linked-role --aws-service-name ecs.amazonaws.com


# Create the service
aws ecs create-service --cli-input-json file://~/environment/aws-modern-application-workshop/module-2/aws-cli/service-definition.json
