variable "router_name" {
  description = "Name of the router"
  type        = string
}

variable "nat_name" {
  description = "Name of the NAT"
  type        = string
}

variable "region" {
  description = "Region where the router and NAT will be created"
  type        = string
}

variable "network" {
  description = "VPC network to associate the router with"
  type        = string
}