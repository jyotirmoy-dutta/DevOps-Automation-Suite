#!/bin/bash
# cloud_cost_estimator.sh - Estimates AWS cloud resource costs
# Usage: ./cloud_cost_estimator.sh
# Requires AWS CLI configured with appropriate permissions.

if ! command -v aws &> /dev/null; then
    echo "AWS CLI not found. Please install and configure AWS CLI."
    exit 1
fi

echo "Fetching AWS cost and usage summary..."
aws ce get-cost-and-usage \
    --time-period Start=$(date -d '1 month ago' +%Y-%m-01),End=$(date +%Y-%m-%d) \
    --granularity MONTHLY \
    --metrics "BlendedCost" \
    --query 'ResultsByTime[*].Total.BlendedCost.Amount' \
    --output text

echo -e "\nEC2 Instances:"
aws ec2 describe-instances --query 'Reservations[*].Instances[*].[InstanceId,InstanceType,State.Name]' --output table

echo -e "\nS3 Buckets:"
aws s3 ls

echo -e "\nRDS Instances:"
aws rds describe-db-instances --query 'DBInstances[*].[DBInstanceIdentifier,DBInstanceClass,Engine,DBInstanceStatus]' --output table

echo "Cloud cost estimation complete." 