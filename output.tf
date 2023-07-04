output "region" {
  value       = var.region
  description = "Exoscale SOS (Simple Object Storage) Region to store Terraform State."
  sensitive   = false
}

output "exoscale_zone" {
  value       = var.exoscale_zone
  description = "Exoscale zone where you launched your resources."
  sensitive   = false
}

/*
output "public_ip_address" {
  value       = module.sf_compute_instance.public_ip_address
  description = "The instance IPv4 address."
  sensitive   = false
}

output "sf_sks_kubeconfig" {
  value       = module.sf_sks_kubeconfig.kubeconfig
  description = "The generated kubeconfig in YAML (Yet Another Markup Language) format."
  sensitive   = true
}

output "sf_sks_cluster_endpoint" {
  value       = module.sf_sks_cluster.endpoint
  description = "Shadowflight SKS Cluster Endpoint."
  sensitive   = false
}

output "sf_sks_worker_nodepool_id" {
  value       = module.sf_sks_worker_nodepool.instance_pool_id
  description = "Shadowflight SKS Worker Nodepool ID."
  sensitive   = false
}
*/
/*
output "anti_affinity_group_ids" {
  value     = module.shadowflight_anti_affinity_group.id
  sensitive = false
}

output "private_network_ids" {
  value     = module.shadowflight_private_network.id
  sensitive = false
}

output "security_group_ids" {
  value     = module.shadowflight_security_group.id
  sensitive = false
}

output "cluster_id" {
  value     = module.shadowflight_sks_cluster.id
  sensitive = false
}

output "kubeconfig" {
  value       = module.shadowflight_sks_kubeconfig.kubeconfig
  description = "The generated kubeconfig in YAML (Yet Another Markup Language) format."
  sensitive   = true
}
*/
