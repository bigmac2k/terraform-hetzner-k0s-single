module "k0sctl" {
  source = "github.com/bigmac2k/terraform-k0sctl"
  clustername = "k0s"
  controller_worker_addrs = [{
    addr = hcloud_server.server.ipv4_address
    private_interface = ""
  }]
  kubeapiIp = hcloud_server.server.ipv4_address
  k0s_version = var.k0s_version
}
