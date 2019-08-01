/*****
Common Variables: Azure provider - Autoloaded from Terragrunt.
*****/

variable "region" {
  description = "The Azure region (e.g. 'australiaeast'). Autoloaded from region.tfvars."
  type        = string
  default     = ""
}

/*****
VNET Module Variables - https://github.com/mashbynz/tf-mod-azure-vnet
*****/

variable "vnet_name" {
  type        = string
  description = ""
  default     = ""
}

variable "vnet_addressspace" {
  type        = list(string)
  description = ""
  default     = []
}

variable "vnet_ddos_name" {
  type        = string
  description = ""
  default     = ""
}

variable "gateway_nsg_name" {
  type        = string
  description = ""
  default     = ""
}
variable "gateway_subnet_name" {
  type        = string
  description = ""
  default     = ""
}

variable "gateway_subnet_prefix" {
  type        = string
  description = ""
  default     = ""
}

variable "firewall_subnet_name" {
  type        = string
  description = ""
  default     = ""
}

variable "firewall_subnet_prefix" {
  type        = string
  description = ""
  default     = ""
}

variable "gateway_rt_name" {
  type        = string
  description = ""
  default     = ""
}

variable "gateway_rt_prefix" {
  type        = string
  description = ""
  default     = ""
}

variable "gateway_rt_nexthop_type" {
  type        = string
  description = ""
  default     = ""
}

variable "gateway_rt_nexthop_ip" {
  type        = string
  description = ""
  default     = ""
}

variable "firewall_allocation_method" {
  type        = string
  description = ""
  default     = ""
}

variable "firewall_sku" {
  type        = string
  description = ""
  default     = ""
}

variable "vpngw_allocation_method" {
  type        = string
  description = ""
  default     = ""
}

variable "vpngw_type" {
  type        = string
  description = ""
  default     = ""
}

variable "vpngw_vpn_type" {
  type        = string
  description = ""
  default     = ""
}

variable "vpngw_sku" {
  type        = string
  description = ""
  default     = ""
}

variable "vpngw_private_alloc" {
  type        = string
  description = ""
  default     = ""
}

variable "vpngw_client_address" {
  type        = list(string)
  description = ""
  default     = []
}

/*****
Label Module Variables
*****/

variable "namespace" {
  type        = string
  default     = ""
  description = "Namespace, which could be your organization name or abbreviation, e.g. 'eg' or 'cp'"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment, e.g. 'prod', 'staging', 'dev', 'pre-prod', 'UAT'"
}

variable "sharedservices_name" {
  type        = string
  default     = ""
  description = "Solution name, e.g. 'app' or 'jenkins'"
}

variable "class" {
  type        = string
  default     = ""
  description = "the type of resource e.g. 'sharedservices' or 'app1'"
}

variable "delimiter" {
  type        = string
  default     = ""
  description = "Delimiter to be used between `namespace`, `environment`, `stage`, `name` and `attributes`"
}

variable "attributes" {
  type        = list(string)
  default     = []
  description = "Additional attributes (e.g. `1`)"
}

variable "tags" {
  type        = map(string)
  default     = {}
  description = "Additional tags (e.g. `map('BusinessUnit','XYZ')`"
}

variable "regex_replace_chars" {
  type        = string
  default     = "/[^a-zA-Z0-9-]/"
  description = "Regex to replace chars with empty string in `namespace`, `environment`, `stage` and `name`. By default only hyphens, letters and digits are allowed, all other chars are removed"
}

variable "context" {
  type = object({
    namespace           = string
    environment         = string
    stage               = string
    name                = string
    enabled             = bool
    delimiter           = string
    attributes          = list(string)
    label_order         = list(string)
    tags                = map(string)
    additional_tag_map  = map(string)
    regex_replace_chars = string
  })
  default = {
    namespace           = ""
    environment         = ""
    stage               = ""
    name                = ""
    enabled             = true
    delimiter           = ""
    attributes          = []
    label_order         = []
    tags                = {}
    additional_tag_map  = {}
    regex_replace_chars = ""
  }
  description = "Default context to use for passing state between label invocations"
}
