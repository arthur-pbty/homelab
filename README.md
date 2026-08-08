# Homelab - Infrastructure as Code

Déploiement automatisé de 3 VMs Proxmox (Réseau, Média, Applications) et configuration de tous les services (Docker) via Terraform et Ansible.

## Prérequis
- Terraform >= 1.5.0
- Ansible
- Un serveur Proxmox VE avec un template Debian/Ubuntu (ex: ID 9000)
- Une clé SSH publique

## Structure du projet
- `terraform/` : Provisionne les 3 VMs sur Proxmox.
- `ansible/` : Configure l'OS, installe Docker et déploie les conteneurs.
- `.github/workflows/` : Vérifications automatiques (lint, formatage).

## Démarrage rapide

### 1. Provisionner l'infrastructure (Terraform)
Allez dans le dossier `terraform/`, copiez le fichier d'exemple et renseignez vos valeurs Proxmox :
```bash
cd terraform
cp terraform.tfvars.example terraform.tfvars
# Éditez terraform.tfvars avec vos identifiants Proxmox et IPs souhaitées
```
Initialisez et appliquez la configuration :
```bash
terraform init
terraform plan
terraform apply
```

### 2. Configurer les VMs (Ansible)
De retour à la racine, créez votre inventaire Ansible à partir de l'exemple :
```bash
cp ansible/inventory.ini.example ansible/inventory.ini
# Vérifiez les IPs dans ansible/inventory.ini
```
Lancez le playbook Ansible :
```bash
cd ansible
ansible-playbook -i inventory.ini playbook.yml
```
Les VMs sont prêtes et tous les services Docker sont démarrés.

## Sécurité
- **Ne committez jamais** les fichiers `terraform.tfvars` ou `ansible/inventory.ini` (ignorés par défaut).
- Pensez à éditer le playbook Ansible pour remplacer `ton@email.com` et `TOKEN_GITEA` par vos vraies valeurs.
