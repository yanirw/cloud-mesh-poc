resource "google_compute_subnetwork" "subnetwork" {
  name          = var.subnet_name
  ip_cidr_range = var.subnet_cidr
  region        = var.region
  network       = var.vpc_network


  dynamic "secondary_ip_range" {
    for_each = var.secondary_ranges != null ? var.secondary_ranges : []
    content {
      range_name    = secondary_ip_range.value.name
      ip_cidr_range = secondary_ip_range.value.cidr
    }
  }

}

