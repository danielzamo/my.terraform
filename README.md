# Terraform

Utilizando Terraform desde VM con Fedora 34

## Instalar Terraform

```bash
dnf -y upgrade
# Instalar terraform
dnf install -y dnf-plugins-core
dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
dnf install terraform
```
