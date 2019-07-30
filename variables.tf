# var.ssrg_name = "prodsharedservices-rg"
# var.primarylocation = "australiaeast"
# var.ssvnet_name = "prodsharedservces-vnet"
# var.ssvnet_addressspace = ["10.48.0.0/16"]
# var.ssvnetddos_name = "prodsharedservices-ddos"
# var.gatewaynsg_name = "prodsharedservicesgw-nsg"
# var.gatewaysubnet_name = "GatewaySubnet"
# var.gatewaysubnet_prefix = "10.48.0.0/27"
# var.firewallsubnet_name = "AzureFirewallSubnet"
# var.firewallsubnet_prefix = "10.48.1.0/24"
# var.GatewayRT_name = "prodsharedservicesgw-rt"
# var.GatewayRT_prefix = "0.0.0.0/0"
# var.GatewayRT_nexthoptype = "VirtualAppliance"
# var.GatewayRT_nexthopIP = "10.48.1.4"

variable "ssrg_name" {
  type        = string
  description = "Name of the Resource Group that holds resources for Shared Services"
}

variable "primarylocation" {
  type        = string
  description = "description"
}

variable "ssvnet_name" {
  type        = string
  description = "description"
}

variable "ssvnet_addressspace" {
  description = "description"
  type = string
}

variable "ssvnetddos_name" {
  description = "description"
  type = string
}
/*
variable "gatewaynsg_name" {
  description = "description"
  type = string
}
*/
variable "gatewaysubnet_name" {
  description = "description"
  type = string
}

variable "gatewaysubnet_prefix" {
  description = "description"
  type = string
}

variable "firewallsubnet_name" {
  description = "description"
  type = string
}

variable "firewallsubnet_prefix" {
  description = "description"
  type = string
}
/*
variable "GatewayRT_name" {
  description = "description"
  type = string
}

variable "GatewayRT_prefix" {
  description = "description"
  type = string
}

variable "GatewayRT_nexthoptype" {
  description = "description"
  type = string
}

variable "GatewayRT_nexthopIP" {
  description = "description"
  type = string
}
*/