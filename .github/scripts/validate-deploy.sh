#!/bin/bash
Gateway_name="$(cat terraform.tfvars | grep  "name_prefix" | awk -F'=' '{print $2}' | sed 's/[""]//g'| sed 's/[[:space:]]//g')"
REGION="$(cat terraform.tfvars | grep  "region" | awk -F'=' '{print $2}' | sed 's/[""]//g' | sed 's/[[:space:]]//g')"

echo "Gateway_name: ${Gateway_name}"
echo "REGION: ${REGION}"

#aws configure set region ${REGION}
#aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
#aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}

echo "Checking transit gateway exists with Name in AWS: ${Gateway_name}"

Gateway_ID=""
Gateway_ID=$(aws ec2 describe-transit-gateways --region $REGION| grep $Gateway_name)

echo "alias_name: ${Gateway_name}"
if [[(${Gateway_ID} == "") ]]; then
  echo "VPN NOT found "
   exit 1
else
   TransitGatewayId="$(aws ec2 describe-transit-gateways --region $REGION | grep TransitGatewayId | awk -F':' '{print $2}' | sed 's/[""]//g' | sed 's/[[:space:]]//g')"
    echo "Transit Gateway Found - TransitGatewayId = ${TransitGatewayId}"    
fi