#output "k0sctl_yaml" {
#  value = module.k0sctl.k0sctl_yaml
#}
output "kubeconfig" {
  sensitive = true
  value = module.k0sctl.kubeconfig
}
output "cluster_ca_certificate" {
  sensitive = true
  value = module.k0sctl.cluster_ca_certificate
}
output "client_certificate" {
  sensitive = true
  value = module.k0sctl.client_certificate
}
output "client_key" {
  sensitive = true
  value = module.k0sctl.client_key
}
output "ip" {
  value = hcloud_server.server.ipv4_address
}
