resource "random_id" "ssh_key_name" {
  byte_length = 6
  prefix = var.clustername
}

resource "hcloud_ssh_key" "ssh_root" {
  name       = random_id.ssh_key_name.dec
  public_key = file("~/.ssh/id_rsa.pub")
}
