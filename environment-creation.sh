#!/bin/bash

# Define variables
resourceGroupName="ChangeMe"
vmName="ChangeMe"
vmSize="Standard_DS2_v2"
adminUser="ChangeMe"
adminPassword="ChangeMe"  # Replace this with your desired password
vnetName="ChangeMe"
subnetName="ChangeMe"
publicIpAddressName="ChangeMe"
nsgName="ChangeMe"

# Create a resource group
az group create --name $resourceGroupName --location eastus

# Create a virtual network and subnet
az network vnet create --name $vnetName --resource-group $resourceGroupName --subnet-name $subnetName

# Create a public IP address
az network public-ip create --name $publicIpAddressName --resource-group $resourceGroupName --sku Standard

# Create a network security group
az network nsg create --name $nsgName --resource-group $resourceGroupName

# Create a virtual network interface
az network nic create --name "${vmName}VMNic" --resource-group $resourceGroupName --vnet-name $vnetName --subnet $subnetName --network-security-group $nsgName --public-ip-address $publicIpAddressName

# Create the Windows virtual machine
az vm create \
  --resource-group $resourceGroupName \
  --name $vmName \
  --location eastus \
  --nics "${vmName}VMNic" \
  --image Win2019Datacenter \
  --admin-username $adminUser \
  --admin-password $adminPassword \
  --size $vmSize
