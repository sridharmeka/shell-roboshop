#!/bin/bash


AMI_ID="ami-09c813fb71547fc4f"
SG_ID="sg-0a95ef1237f82de1c"
INSTANCES=("MONGODB" "REDIS" "MYSQL" "RABBITMQ" "CATALOGUE" "USER" "CART" "PAYMENT" "SHIPPING" "DISPATCH")
ZONE_ID="Z04210263NS79GNN5JP59"
DOMAIN_NAME="sridharmeka.site"

for INSTANCES in ${INSTANCES[@]}
do 
    INSTANCES_ID=$(aws ec2 run-instances --image-id ami-09c813fb71547fc4f --instance-type t2.micro --security-group-ids sg-0a95ef1237f82de1c --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$instance}]" \
    --query "Instances[0].InstanceId" --output text)

if  [ "$instance" != "frontend" ]
then
    ip=$(aws ec2 describe-instances --instance-ids $INSTANCES_ID --query "Reservations[0].Instances[0].PrivateIpAddress" --output text)
else
    ip=$(aws ec2 describe-instances --instance-ids $INSTANCES_ID --query "Reservations[0].Instances[0].PublicIpAddress" --output text)
fi
    echo "$instance IP Address: $IP"

done 