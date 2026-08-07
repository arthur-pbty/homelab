# Contribution guidelines

Merci de contribuer. Quelques règles rapides pour un projet d'entreprise :

- Ouvrir une Pull Request pour toute modification non triviale.
- Commits clairs, utiliser un style type `chore:`, `feat:`, `fix:`.
- Ne jamais committer de secrets (voir `terraform/variables.tf.example` et `ansible/inventory.ini.example`).
- Utiliser `ansible-vault` pour chiffrer les secrets Ansible.
- Pour Terraform, configurez un backend distant (S3/GCS) pour l'état.
- Exécuter `pre-commit install` localement avant de pousser.
