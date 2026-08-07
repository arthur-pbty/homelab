variable "pm_endpoint" {
  description = "URL de l'API Proxmox (ex: https://proxmox.example:8006/)"
  type        = string
}

# Format: utilisateur@pve!nom_du_token
variable "pm_api_token" {
  description = "Token Proxmox (format user@pam!token_name). Ne pas committer."
  type        = string
}

variable "pm_api_secret" {
  description = "Secret Proxmox associé au token. Ne pas committer."
  type        = string
  sensitive   = true
}

variable "target_node" {
  description = "Nom du nœud Proxmox cible"
  type        = string
  default     = "pve"
}

variable "debian_template_id" {
  description = "ID du template Debian à cloner"
  type        = number
  default     = 9000
}

variable "ssh_public_key" {
  description = "Clé publique SSH à injecter dans la VM"
  type        = string
}
