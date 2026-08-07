# homelab — Infrastructure-as-Code

Ce dépôt contient des configurations Terraform et Ansible destinées à déployer et configurer un homelab.

Objectif
- Préparer le dépôt pour publication publique en respectant les bonnes pratiques : ne pas committer de secrets, ajouter des contrôles automatiques, fournir des exemples et une documentation claire.

Structure principale
- `terraform/` : code Terraform (providers, ressources).
- `ansible/` : playbooks, rôles et exemples d'inventaire.
- `.github/workflows/ci.yml` : pipeline CI pour checks (format, validate, ansible-lint, pre-commit).
- `.pre-commit-config.yaml` : hooks locaux à exécuter avant les commits.

Gestion des secrets — règles simples
- Ne commitez jamais de secrets (tokens, mots de passe, clés privées).
- Déclarez vos variables dans `terraform/variables.tf` (dans le dépôt) et fournissez les valeurs sensibles via un fichier `terraform/terraform.tfvars` local (ignoré) ou via un backend/secret manager.
- Pour Ansible, stockez les secrets chiffrés avec `ansible-vault` dans `group_vars`/`host_vars`.

Utilisation recommandée — Terraform
1. Copier l'exemple de variables :

```bash
cp terraform/terraform.tfvars.example terraform/terraform.tfvars
# remplir terraform/terraform.tfvars avec vos valeurs locales (ne pas committer)
```

2. Initialiser et valider :

```bash
cd terraform
terraform init
terraform validate
terraform plan -var-file=terraform.tfvars
terraform apply -var-file=terraform.tfvars
```

Remarque : en production, configurez un backend distant (S3, GCS, Terraform Cloud) pour stocker l'état Terraform de façon sécurisée.

Utilisation recommandée — Ansible
- Utiliser `ansible/inventory.ini.example` comme modèle et ne pas committer l'inventaire réel.
- Chiffrer les données sensibles :

```bash
ansible-vault encrypt ansible/group_vars/all/vault.yml
ansible-playbook playbook.yml --ask-vault-pass
```

Qualité et automatisation
- Installer les hooks locaux : `pre-commit install`.
- Le pipeline CI exécute les vérifications automatiques lors de `push`/`pull_request`.

Nettoyage d'un historique contenant des secrets
- Si des secrets ont déjà été poussés, il faut réécrire l'historique (`git filter-repo` ou BFG). C'est une opération disruptive : coordonner avec les contributeurs avant de la lancer.

Publication
1. Vérifier qu'aucun fichier sensible n'est présent.
2. S'assurer que `.gitignore` contient les patterns appropriés (`*.tfstate`, `*.tfvars`, etc.).
3. Commit et push :

```bash
git add .
git commit -m "chore: prepare repo for public release — remove secrets, add CI and docs"
git push origin main
```

Besoin d'aide ?
- Je peux : créer le commit localement, lancer `pre-commit` et exécuter les commandes de validation; ou t'assister pour purger l'historique si nécessaire.

