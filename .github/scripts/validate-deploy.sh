#!/bin/bash
VPN_name="$(cat terraform.tfvars | grep  "name_prefix" | awk -F'=' '{print $2}' | sed 's/[""]//g'| sed 's/[[:space:]]//g')"
REGION="$(cat terraform.tfvars | grep  "region" | awk -F'=' '{print $2}' | sed 's/[""]//g' | sed 's/[[:space:]]//g')"

echo "VPN_name: ${VPN_name}"
echo "REGION: ${REGION}"

#aws configure set region ${REGION}
#aws configure set aws_access_key_id ${AWS_ACCESS_KEY_ID}
#aws configure set aws_secret_access_key ${AWS_SECRET_ACCESS_KEY}

echo "Checking VPN exists with Name in AWS: ${VPN_name}"

VPN_ID=""
VPN_ID=$(aws ec2 describe-client-vpn-endpoints --region $REGION| grep $VPN_name)

echo "alias_name: ${VPN_name}"
if [[(${VPN_ID} == "") ]]; then
  echo "VPN NOT found "
   exit 1
else
   VPN_endpoint="$(aws ec2 describe-client-vpn-endpoints --region $REGION | grep ClientVpnEndpointId | awk -F':' '{print $2}' | sed 's/[""]//g' | sed 's/[[:space:]]//g')"
    echo "VPN Found - ClientVpnEndpointId = ${VPN_endpoint}"    
fi