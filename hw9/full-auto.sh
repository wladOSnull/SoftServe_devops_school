#!/bin/bash

###
### IaaS
###
eval \
ansible-playbook main.yaml --check && \
terraform init  && \
terraform validate -json && \
terraform plan -out=plan && \
terraform apply plan

###
### to visit deployed project
###
public_ip_of_aws_istance=`cat /tmp/file-ip`
eval xdg-open "http://${public_ip_of_aws_istance}/"

###
### a final message
###
echo -e "\n
################################################################################################

Auto opening project: http://${public_ip_of_aws_istance}/
To get access to AWS instance via SSH: ssh -i \"aws_key\" ubuntu@${public_ip_of_aws_istance}

################################################################################################\n\n"

### hostnamectl - to check Linux info 