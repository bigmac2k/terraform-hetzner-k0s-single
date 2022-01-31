locals {
  k0sctl_yaml = templatefile("${path.module}/k0sctl.yaml.tmpl", {
    clustername = var.clustername
    version = var.k0s_version
    externalAddress = var.externalAddress
  })
}
