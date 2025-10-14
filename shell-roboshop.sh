#!/bin/bash

AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-0fd3ac047a50d777a" 
INSTANCES=("mongodb" "redis" "mysql" "rabbitmq" "catalogue" "user" "cart" "shipping" "payment" "dispatch" "frontend")
ZONE_ID="Z04210263NS79GNN5JP59" 
DOMAIN_NAME="sridharmeka.site"

for instance in ${INSTANCES[@]}
do 
  INSTANCE_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t3.micro --security-group-ids sg-0fd3ac047a50d777a --tag-specifications "ResourceType=instance,Tags=[{Key=Name, Value=$instance}]" --query "Instances[0].InstanceId" --output text)
    if [ $instance != "frontend" ]
    then
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].
        Instances[0].PrivateIpAddress" --output text)
        
    else
        IP=$(aws ec2 describe-instances --instance-ids $INSTANCE_ID --query "Reservations[0].
        Instances[0].PublicIpAddress" --output text)
        
    fi
    echo "$instance IP address: $IP"

done 
