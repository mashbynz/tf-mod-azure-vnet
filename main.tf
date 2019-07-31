# Resource Group

resource "azurerm_resource_group" "default" {
  name     = module.rg_label.id
  location = var.region

  tags = module.rg_label.tags
}

# VNet

resource "azurerm_virtual_network" "default" {
  name                = module.vnet_label.id
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  address_space       = var.vnet_addressspace

  ddos_protection_plan {
    id     = azurerm_network_ddos_protection_plan.default.id
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

resource "azurerm_network_ddos_protection_plan" "default" {
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
  # name                 = module.firewall_subnet_label.id
  name                 = "AzureFirewallSubnet"
  resource_group_name  = azurerm_resource_group.default.name
  virtual_network_name = azurerm_virtual_network.default.name
  address_prefix       = var.firewall_subnet_prefix
}

# Route Table

resource "azurerm_route_table" "default" {
  name                = module.rt_label.id
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
}

resource "azurerm_route" "default" {
  name                   = module.route_label.id
  resource_group_name    = azurerm_resource_group.default.name
  route_table_name       = azurerm_route_table.default.name
  address_prefix         = var.gateway_rt_prefix
  next_hop_type          = var.gateway_rt_nexthop_type
  next_hop_in_ip_address = var.gateway_rt_nexthop_ip
}

resource "azurerm_subnet_route_table_association" "default" {
  subnet_id      = azurerm_subnet.gateway.id
  route_table_id = azurerm_route_table.default.id
}

# Azure Firewall

resource "azurerm_public_ip" "FirewallPIP" {
  name                = module.fw_pip_label.id
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name
  allocation_method   = var.firewall_allocation_method
  sku                 = var.firewall_sku
}

resource "azurerm_firewall" "default" {
  name                = module.firewall_label.id
  location            = azurerm_resource_group.default.location
  resource_group_name = azurerm_resource_group.default.name

  ip_configuration {
    name                 = module.ipconfig_label.id
    subnet_id            = azurerm_subnet.firewall.id
    public_ip_address_id = azurerm_public_ip.FirewallPIP.id
  }
}

# VPN Gateway

resource "azurerm_public_ip" "default" {
  name                = module.vgw_pip_label.id
  location            = var.region
  resource_group_name = azurerm_resource_group.default.name

  allocation_method   = "Dynamic" #var.vpngw_allocation_method
}

resource "azurerm_virtual_network_gateway" "default" {
  name                = module.vgw_label.id
  location            = var.region
  resource_group_name = azurerm_public_ip.default.resource_group_name

  type     = var.vpngw_type
  vpn_type = var.vpngw_vpn_type

  active_active = false
  enable_bgp    = false
  sku           = var.vpngw_sku

  ip_configuration {
    name                          = module.ipconfig_label.id
    public_ip_address_id          = azurerm_public_ip.default.id
    private_ip_address_allocation = var.vpngw_private_alloc
    subnet_id                     = azurerm_subnet.gateway.id
  }

  vpn_client_configuration {
    address_space = var.vpngw_client_address

  }
}
