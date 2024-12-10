#!/bin/bash

# Input Arguments
app_registration_name="$1"
app_registration_owners="$2"
app_registration_description="$3"
app_registration_expiry="$4"

set -x

# Initialize Terraform
terraform init --upgrade

# Generate a plan before applying, using the input arguments
terraform plan \
  -var="app_registration_name=${app_registration_name}" \
  -var="app_registration_owners=${app_registration_owners}" \
  -var="app_registration_description=${app_registration_description}" \
  -var="app_registration_expiry=${app_registration_expiry}" \
  -refresh true

OLDIFS=$IFS
IFS=$'\n'
for ln in $(terraform apply -auto-approve -json); do
    case $(echo $ln | jq -r '."@level"') in 
    "error" )
    address=$(echo $ln | jq -r '.diagnostic.address')
    resource=$(echo $ln | jq -r '.diagnostic.summary' | cut -d'"' -f2)
    terraform import $address $resource
    ;;
    *)
    ;;
    esac
done

# Restore the original IFS
IFS=$OLDIFS

# Clean up by applying Terraform once more after all imports
  terraform apply -auto-approve 
  terraform fmt --recursive
