variable "clustername" {
  type        = string
  description = "k0s cluster name"
  default     = "k0s"
}
variable "k0s_version" {
  type        = string
  default     = "v1.22.5+k0s.0"
  description = "Version of k0s to install"
}
variable "location" {
  type        = string
  default     = "nbg1"
  description = "hetzner location"
}
variable "server_type" {
  type = string
  default = "cx11"
}
variable "extralabels" {
  type = map
  default = {}
}
