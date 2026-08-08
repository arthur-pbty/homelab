# Terraform

Provisionne 3 VMs Debian/Ubuntu sur Proxmox VE (Network, Media, Apps).

## Utilisation
1. Copiez `terraform.tfvars.example` en `terraform.tfvars` et renseignez vos valeurs.
2. Initialisez Terraform : `terraform init`
3. Vérifiez le plan : `terraform plan`
4. Appliquez : `terraform apply`

## Fichiers principaux
- `providers.tf` : Configuration du provider Proxmox.
- `variables.tf` : Déclaration des variables.
- `main.tf` : Ressources des 3 VMs (CPU, RAM, IP, Clone).
- `outputs.tf` : Sorties utiles (IPs des VMs).
