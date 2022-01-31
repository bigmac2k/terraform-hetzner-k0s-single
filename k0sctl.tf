module "k0sctl" {
  source = "./k0sctl"
  clustername = "k0s"
  externalAddress = hcloud_server.server.ipv4_address
  k0s_version = var.k0s_version
}
