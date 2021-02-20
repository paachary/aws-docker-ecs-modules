#!/bin/sh

aws cloudformation create-stack --stack-name BlogAppRDSStack \
--capabilities CAPABILITY_NAMED_IAM \
--template-body file://~/environment/aws-docker-ecs-modules/02-rds-module/templates/rds-resources.yaml \
--parameter file://~/environment/aws-docker-ecs-modules/02-rds-module/parameters/rds-resources-params.json
