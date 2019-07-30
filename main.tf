# Resource Group

resource "azurerm_resource_group" "default" {
  name     = module.rg_label.id
  location = var.region
}

# VNet

resource "azurerm_virtual_network" "default" {
  name                = module.vnet_label.id
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  address_space       = var.vnet_addressspace

  ddos_protection_plan {
    id     = azurerm_ddos_protection_plan.default.id
    enable = true
  }
}

# NSG

resource "azurerm_network_security_group" "default" {
  name                = module.nsg_label.id
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
}

# DDoS

resource "azurerm_ddos_protection_plan" "default" {
  name                = module.ddos_label.id
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
}

# Subnets

resource "azurerm_subnet" "gateway" {
  name                 = module.gateway_subnet_label.id
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefix       = var.gateway_subnet_prefix
}

resource "azurerm_subnet" "firewall" {
  name                 = module.firewall_subnet_label.id
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefix       = var.firewall_subnet_prefix
}

# VPN Gateway



# ExpressRoute Gateway



# Route Table

resource "azurerm_route_table" "default" {
  name                = module.rt_label.id
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
}

resource "azurerm_route" "default" {
  name                   = module.route_label.id
  resource_group_name    = azurerm_resource_group.default.name
  route_table_name       = azurerm_route_table.gateway.name
  address_prefix         = var.gateway_rt_prefix
  next_hop_type          = var.gateway_rt_nexthop_type
  next_hop_in_ip_address = var.gateway_rt_nexthop_ip
}

resource "azurerm_subnet_route_table_association" "default" {
  subnet_id      = azurerm_subnet.gateway.id
  route_table_id = azurerm_route_table.gateway.id
}
