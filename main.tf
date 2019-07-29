# Resource Group

resource "azurerm_resource_group" "SharedServicesRG" {
  name     = var.ssrg_name
  location = var.primarylocation
}

# VNet

resource "azurerm_virtual_network" "SharedServicesVNet" {
  name                = var.ssvnet_name
  location            = azurerm_resource_group.SharedServicesRG.location
  resource_group_name = azurerm_resource_group.SharedServicesRG.name
  address_space       = var.ssvnet_addressspace
  
  ddos_protection_plan {
    id     = azurerm_ddos_protection_plan.SharedServicesDDoS.id
    enable = true
  }

# NSG

resource "azurerm_network_security_group" "gatewayNSG" {
  name                = var.gatewaynsg_name
  location            = azurerm_resource_group.SharedServicesRG.location
  resource_group_name = azurerm_resource_group.SharedServicesRG.name
}

# DDoS

resource "azurerm_ddos_protection_plan" "SharedServicesDDoS" {
  name                = var.ssvnetddos_name
  location            = azurerm_resource_group.SharedServicesRG.location
  resource_group_name = azurerm_resource_group.SharedServicesRG.name
}

# Subnets

resource "azurerm_subnet" "SSGatewaySubnet" {
  name                 = var.gatewaysubnet_name
  resource_group_name  = azurerm_resource_group.SharedServicesRG.name
  virtual_network_name = azurerm_virtual_network.SharedServicesVNet.name
  address_prefix       = var.gatewaysubnet_prefix
}

resource "azurerm_subnet" "SSFirewallSubnet" {
  name                 = var.firewallsubnet_name
  resource_group_name  = azurerm_resource_group.SharedServicesRG.name
  virtual_network_name = azurerm_virtual_network.SharedServicesVNet.name
  address_prefix       = var.firewallsubnet_prefix
}

# VPN Gateway



# ExpressRoute Gateway



# Route Table

resource "azurerm_route_table" "SSGatewayRT" {
  name                = "example-routetable"
  location            = azurerm_resource_group.SharedServicesRG.location
  resource_group_name = azurerm_resource_group.SharedServicesRG.name

  route {
    name                   = var.GatewayRT_name
    address_prefix         = var.GatewayRT_prefix
    next_hop_type          = var.GatewayRT_nexthoptype
    next_hop_in_ip_address = var.GatewayRT_nexthopIP
  }
}

resource "azurerm_subnet_route_table_association" "SSGatewayRT_association" {
  subnet_id      = azurerm_subnet.SSGatewaySubnet.id
  route_table_id = azurerm_route_table.SSGatewayRT.id
}

