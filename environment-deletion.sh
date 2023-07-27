#!/bin/bash

# Define the resource group and VM name (same as used in the create script)
resourceGroupName="ChangeMe"
vmName="ChangeMe"

# Delete the virtual machine
az vm delete --resource-group $resourceGroupName --name $vmName --yes

# Delete the resource group and all its resources
az group delete --name $resourceGroupName --yes --no-wait
