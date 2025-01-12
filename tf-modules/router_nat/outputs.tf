output "router_name" {
  description = "Name of the router"
  value       = google_compute_router.router.name
}

output "nat_name" {
  description = "Name of the NAT"
  value       = google_compute_router_nat.nat.name
}