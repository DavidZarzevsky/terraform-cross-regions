#!/usr/bin/env bash
set -x

aws ec2 authorize-client-vpn-ingress --profile $AWSCLIPROFILE --region $REGION --client-vpn-endpoint-id $CLIENT_VPN_ID --target-network-cidr $TARGET_CIDR --authorize-all-groups