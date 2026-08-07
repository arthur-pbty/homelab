
# Ansible — notes et bonnes pratiques

- Ne stockez jamais d'inventaires contenant des identifiants en clair. Utilisez `ansible/inventory.ini.example` comme modèle.
- Structure recommandée : `roles/`, `group_vars/`, `host_vars/`.

Gestion des secrets
- Utilisez `ansible-vault` pour chiffrer les variables sensibles :

```bash
ansible-vault encrypt ansible/group_vars/all/vault.yml
ansible-playbook playbook.yml --ask-vault-pass
```

Exécution
- Lancer un playbook en précisant l'inventaire exemple (après l'avoir adapté localement) :

```bash
cp ansible/inventory.ini.example ansible/inventory.ini
# éditer ansible/inventory.ini localement (ne pas committer)
ansible-playbook -i ansible/inventory.ini ansible/playbook.yml
```

Bonnes pratiques
- Automatiser les tests de playbooks avec `ansible-lint` et des pipelines CI.
- Préparer des `roles/` réutilisables et documenter leurs variables et dépendances.
