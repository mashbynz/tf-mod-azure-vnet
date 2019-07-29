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
  default     = "prodsharedservices-rg"
}

variable "primarylocation" {
  type        = string
  description = "description"
  default     = "australiaeast"
}

variable "ssvnet_name" {
  type        = string
  description = "description"
  default     = "prodsharedservces-vnet"
}

variable "ssvnet_addressspace" {
  description = "description"
  default     = ["10.48.0.0/16"]
}

variable "ssvnetddos_name" {
  description = "description"
  default     = "prodsharedservices-ddos"
}

variable "gatewaynsg_name" {
  description = "description"
  default     = "prodsharedservicesgw-nsg"
}

variable "gatewaysubnet_name" {
  description = "description"
  default     = "GatewaySubnet"
}

variable "gatewaysubnet_prefix" {
  description = "description"
  default     = "10.48.0.0/27"
}

variable "firewallsubnet_name" {
  description = "description"
  default     = "AzureFirewallSubnet"
}

variable "firewallsubnet_prefix" {
  description = "description"
  default     = "10.48.1.0/24"
}

variable "GatewayRT_name" {
  description = "description"
  default     = "prodsharedservicesgw-rt"
}

variable "GatewayRT_prefix" {
  description = "description"
  default     = "0.0.0.0/0"
}

variable "GatewayRT_nexthoptype" {
  description = "description"
  default     = "VirtualAppliance"
}

variable "GatewayRT_nexthopIP" {
  description = "description"
  default     = "10.48.1.4"
}
