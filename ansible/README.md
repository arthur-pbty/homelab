# Ansible

Configure les 3 VMs créées par Terraform : installe Docker et déploie tous les conteneurs (Traefik, Pi-hole, Immich, Gitea, etc.).

## Utilisation
1. Copiez `inventory.ini.example` en `inventory.ini` et vérifiez les IPs des VMs.
2. Lancez le playbook :
```bash
ansible-playbook -i inventory.ini playbook.yml
```

## Sécurité
Si vous ajoutez des mots de passe ou variables sensibles, utilisez `ansible-vault` :
```bash
ansible-vault encrypt group_vars/all/vault.yml
ansible-playbook -i inventory.ini playbook.yml --ask-vault-pass
```
