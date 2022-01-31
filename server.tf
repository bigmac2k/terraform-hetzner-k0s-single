resource "hcloud_server" "server" {
  name        = "${var.clustername}"
  ssh_keys = [hcloud_ssh_key.ssh_root.name]
  location = var.location
  image       = "ubuntu-20.04"
  server_type = var.server_type
  labels = merge({"fw-${var.clustername}" = ""}, var.extralabels)
}
