# Terraform — notes et bonnes pratiques

- `variables.tf` doit contenir uniquement les déclarations de variables (sans secrets par défaut). Ne commitez pas de valeurs sensibles.
- Fournissez les valeurs locales dans un fichier `terraform.tfvars` (ignoré) ou via variables d'environnement / backend sécurisé.

Recommandations
- Conserver `variables.tf` dans le dépôt pour documenter les variables attendues.
- Inclure un fichier d'exemple `terraform.tfvars.example` (fourni) que chaque contributeur copie en `terraform.tfvars` local.

Backend d'état
- En production, configurez un backend distant (S3, GCS, Terraform Cloud) pour stocker l'état :

```hcl
terraform {
  backend "s3" {
    bucket = "my-terraform-state"
    key    = "homelab/terraform.tfstate"
    region = "eu-west-1"
  }
}
```

Validation locale

```bash
cd terraform
terraform init            # si backend configuré, vérifier les credentials
terraform validate
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

Sécurité
- Marquez les variables sensibles avec `sensitive = true` dans `variables.tf` quand possible.
- Préférez l'utilisation d'un secret manager (Vault, AWS Secrets Manager, etc.) plutôt que de stocker des secrets en clair.

Notes spécifiques
- Le provider Proxmox utilisé dans ce dépôt peut exiger la concaténation d'un `token_id` et d'un `token_secret` selon la version ; vérifiez la documentation du provider avant d'automatiser la distribution des tokens.
