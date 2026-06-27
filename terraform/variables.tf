variable "proxmox_endpoint" {}
variable "proxmox_user" {}
variable "proxmox_password" {
  sensitive = true
}