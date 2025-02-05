provider "azurerm" {
  features {}
  resource_provider_registrations = "none"
  subscription_id                 = "57124af2-ec2e-466c-a744-c046ea95c09a"
}

## Create a resource group
resource "azurerm_resource_group" "temp_rg" {
  name     = "hashitalk-basic-sa-${random_pet.pet_name.id}-rg"
  location = "East US"
}

## Output the resource group name
output "rg_name" {
  value = azurerm_resource_group.temp_rg.name
}

output "rg_location" {
  value = azurerm_resource_group.temp_rg.location
}

## Create a random pet
resource "random_pet" "pet_name" {
  length = 1
}

## Output the random pet name
output "sa_pet_name" {
  value = random_pet.pet_name.id
}

resource "azurerm_virtual_network" "hashitalk_vnet" {
  name                = "hashitalk-${random_pet.pet_name.id}-vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.temp_rg.location
  resource_group_name = azurerm_resource_group.temp_rg.name
}

resource "azurerm_subnet" "hashitalk_subnet" {
  name                 = "vm_subnet"
  resource_group_name  = azurerm_resource_group.temp_rg.name
  virtual_network_name = azurerm_virtual_network.hashitalk_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

output "vm_subnet" {
  value = azurerm_subnet.hashitalk_subnet.id
}