project_id = "yan-lab"
region = "me-west1"

# VPC and Subnet
vpc_name = "gke-vpc-1"
subnet_name = "gke-subnet"
subnet_cidr  = "10.66.1.0/24"
secondary_ranges = [
  {
    name = "pods"
    cidr = "10.0.0.0/16"
  },
  {
    name = "services"
    cidr = "10.1.0.0/16"
  }
]

ip_range_pods = "pods"
ip_range_services = "services"

# Infra GKE cluster variables
cluster_name = "yan-lab-gke-cl"
http_load_balancing = true
network_policy     = false
hpa     = false
master_cidr     = "10.66.0.16/28"
dns_cache     = true
np_name     = "yan-lab-infra-gke-np"
machine_type     = "n2-standard-2"
min_count     = 1
max_count     = 1
disk_size_gb     = 100
disk_type     = "pd-ssd"

# Infra GKE Node pool variables
dns_proxy_np = {
    name                = "yan-lab-gke-np"
    machine_type        = "n2-standard-2"
    node_locations      = "me-west1-a,me-west1-b"
    min_count           =  1
    max_count           =  1
    disk_size_gb        = 50
    disk_type           = "pd-ssd"
    auto_repair         = true
    auto_upgrade        = true
    deletion_protection = true
}

logging_enabled_components = ["SYSTEM_COMPONENTS", "APISERVER", "WORKLOADS"]

monitoring_enabled_components = ["SYSTEM_COMPONENTS", "STORAGE", "HPA", "POD", "DAEMONSET", "DEPLOYMENT", "STATEFULSET", "CADVISOR", "KUBELET"]

monitoring_enable_managed_prometheus = true

master_authorized_networks = [
  {
    cidr_block   = "10.1.0.0/24"
    display_name = "bastion"
  },
  {
    cidr_block   = "147.236.119.0/24"
    display_name = "office"
  }
]

#GKE Namespaces
namespaces = {
    infra = {
        name = "infra"
        labels = {
            ns = "infra"
        }
    }
    cards = {
        name = "cards"
        labels = {
            ns = "cards"
        }
    }
    accounts = {
        name = "accounts"
        labels = {
            ns = "accounts"
        }
    }
    odsc-accounts = {
        name = "odsc-accounts"
        labels = {
            ns = "odsc-accounts"
        }
    }
    odsc-cards = {
        name = "odsc-cards"
        labels = {
            ns = "odsc-cards"
        }
    }
}