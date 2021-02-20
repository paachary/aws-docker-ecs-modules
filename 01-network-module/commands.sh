#!/bin/sh

aws cloudformation create-stack --stack-name BlogAppNWStack \
--capabilities CAPABILITY_NAMED_IAM \
--template-body file://~/environment/aws-docker-ecs-modules/01-network-module/templates/network-resources.yaml \
--parameter file://~/environment/aws-docker-ecs-modules/01-network-module/parameters/network-resources-params.json

aws cloudformation create-stack --stack-name BlogAppSSMStack \
--capabilities CAPABILITY_NAMED_IAM \
--template-body file://~/environment/aws-docker-ecs-modules/01-network-module/templates/ssm-resources.yaml \
--parameter file://~/environment/aws-docker-ecs-modules/01-network-module/parameters/ssm-resources-params.json

aws cloudformation create-stack --stack-name BlogAppNGWStack \
--capabilities CAPABILITY_NAMED_IAM \
--template-body file://~/environment/aws-docker-ecs-modules/01-network-module/templates/natgw-resources.yaml \
--parameter file://~/environment/aws-docker-ecs-modules/01-network-module/parameters/natgw-resources-params.json

aws cloudformation create-stack --stack-name BlogAppIamRoleStack \
--capabilities CAPABILITY_NAMED_IAM \
--template-body file://~/environment/aws-docker-ecs-modules/01-network-module/templates/iam-roles.yaml