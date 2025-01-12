provider "google" {
  project = var.project_id
  region  = var.region
}

# Terraform Backend
terraform {
  backend "gcs" {
    bucket = "lab-tf-state-poc-mesh"
    prefix = "terraform/state"
  }
}

module "vpc" {
  source  = "../../tf-modules/VPC"
  vpc_name = var.vpc_name
}
module "subnet" {
  source        = "../../tf-modules/subnet"
  region        = var.region
  subnet_cidr   = var.subnet_cidr
  subnet_name   = var.subnet_name
  vpc_network   = module.vpc.vpc_name
  secondary_ranges = var.secondary_ranges
}

module "infra-gke" {
  source                     = "../../tf-modules/terraform-google-gke-cluster-private"
  project_id                 = var.project_id
  name                       = var.cluster_name
  region                     = var.region
  network                    = module.vpc.vpc_name
  network_project_id         = var.project_id
  subnetwork                 = module.subnet.subnet_name
  ip_range_pods              = var.ip_range_pods
  ip_range_services          = var.ip_range_services
  http_load_balancing        = var.http_load_balancing
  network_policy             = var.network_policy
  horizontal_pod_autoscaling = var.hpa
  filestore_csi_driver       = false
  enable_private_endpoint    = false
  enable_private_nodes       = true
  master_ipv4_cidr_block     = var.master_cidr
  dns_cache                  = var.dns_cache
  create_service_account     = true
  enable_mesh_certificates   = true

  logging_enabled_components = var.logging_enabled_components

  monitoring_enabled_components = var.monitoring_enabled_components

  monitoring_enable_managed_prometheus = var.monitoring_enable_managed_prometheus

  master_authorized_networks = var.master_authorized_networks

  node_pools = [
    {
      name                = var.np_name
      machine_type        = var.machine_type
      min_count           = var.min_count
      max_count           = var.max_count
      disk_size_gb        = var.disk_size_gb
      disk_type           = var.disk_type
      auto_repair         = true
      auto_upgrade        = true
      deletion_protection = true
    }
  ]
}

module "router_nat" {
  source      = "../../tf-modules/router_nat"
  router_name = "lab-router"
  nat_name    = "lab-nat"
  region      = var.region
  network     = module.vpc.vpc_name
}
