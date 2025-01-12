variable "project_id" {
  description = "The project ID to host the cluster in (required)"
  type        = string
}

variable "region" {
  description = "The region to host the cluster in (required)"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC network"
  type        = string
}

variable "subnet_cidr" {
  description = "CIDR block for the subnet"
  type        = string
}

variable "subnet_name" {
  description = "Name for the subnet"
  type        = string
}
variable "secondary_ranges" {
  description = "Secondary IP ranges for the subnet"
  type        = list(object({
    name = string
    cidr = string
  }))
  default = [
    {
      name = "pods"
      cidr = "10.0.0.0/16"
    },
    {
      name = "services"
      cidr = "10.1.0.0/16"
    }
  ]
}

variable "ip_range_pods" {
  description = "The name of the secondary subnet range to use for pods"
  type        = string
  default     = "pods"
}

variable "ip_range_services" {
  description = "The name of the secondary subnet range to use for services"
  type        = string
  default     = "services"
}

variable "cluster_name" {
  description = "The name of the GKE cluster"
  type        = string
}


variable "http_load_balancing" {
  description = "Enable HTTP load balancing addon"
  type        = bool
  default     = true
}

variable "network_policy" {
  description = "Enable network policy addon"
  type        = bool
  default     = false
}

variable "hpa" {
  description = "Enable horizontal pod autoscaling addon"
  type        = bool
  default     = true
}

variable "master_cidr" {
  description = "The IP range in CIDR notation to use for the hosted master network"
  type        = string
  default     = "10.0.0.0/28"
}

variable "dns_cache" {
  description = "Enable DNS Cache addon"
  type        = bool
  default     = false
}

variable "np_name" {
  description = "The name of the node pool"
  type        = string
}

variable "machine_type" {
  description = "The machine type for the node pool"
  type        = string
}

variable "min_count" {
  description = "The minimum number of nodes in the node pool"
  type        = number
}

variable "max_count" {
  description = "The maximum number of nodes in the node pool"
  type        = number
}

variable "disk_size_gb" {
  description = "The disk size in GB for the node pool"
  type        = number
}

variable "disk_type" {
  description = "The disk type for the node pool"
  type        = string
}

variable "dns_proxy_np" {
  type = object({
    name                = string
    machine_type        = string
    min_count           = number
    max_count           = number
    disk_size_gb        = number
    disk_type           = string
    auto_repair         = bool
    auto_upgrade        = bool
    deletion_protection = bool
    node_locations      = string
  })
}



variable "namespaces" {
  type = map(object({
    name        = string
    labels      = optional(map(string), {})
    annotations = optional(map(string), {})
  }))
}

variable "logging_enabled_components" {
  description = "List of logging enabled components"
  type        = list(string)
  default     = ["SYSTEM_COMPONENTS", "APISERVER", "WORKLOADS"]
}

variable "monitoring_enabled_components" {
  description = "List of monitoring enabled components"
  type        = list(string)
  default     = ["SYSTEM_COMPONENTS", "STORAGE", "HPA", "POD", "DAEMONSET", "DEPLOYMENT", "STATEFULSET", "CADVISOR", "KUBELET"]
}

variable "monitoring_enable_managed_prometheus" {
  description = "Enable managed Prometheus monitoring"
  type        = bool
  default     = true
}

variable "master_authorized_networks" {
  description = "List of master authorized networks"
  type        = list(object({
    cidr_block   = string
    display_name = string
  }))
  default = [
    {
      cidr_block   = "10.1.0.0/24"
      display_name = "bastion"
    },
    {
      cidr_block   = "147.236.119.165/32"
      display_name = "office"
    }
  ]
}