#!/bin/sh

# Create an ecs cluster
aws ecs create-cluster --cluster-name BlogApplication-Cluster

# Create log groups
aws logs create-log-group --log-group-name blogapplication-logs

aws ecs register-task-definition --cli-input-json file://~/environment/aws-docker-ecs-modules/ecs-module/cli/task-definition.json

# Create An Application Load Balancer
aws elbv2 create-load-balancer --name blogapplication-alb --scheme internet-facing --type application --subnets REPLACE_ME_PUBLIC_SUBNET_ONE REPLACE_ME_PUBLIC_SUBNET_TWO > ~/environment/alb-output.json

# Create A Load Balancer Target Group
aws elbv2 create-target-group --name BlogApplication-TargetGroup --port 8000 --protocol TCP --target-type ip --vpc-id REPLACE_ME_VPC_ID --health-check-interval-seconds 10 --health-check-path / --health-check-protocol HTTP --healthy-threshold-count 3 --unhealthy-threshold-count 3 > ~/environment/target-group-output.json

# Create A Load Balancer Listener
aws elbv2 create-listener --default-actions TargetGroupArn=REPLACE_ME_NLB_TARGET_GROUP_ARN,Type=forward --load-balancer-arn REPLACE_ME_NLB_ARN --port 80 --protocol TCP
