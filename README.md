# Terraform

Utilizando Terraform desde VM con Fedora 34

## Instalar Terraform

```bash
nmcli connection modify enp1s0 ipv4.addresses 192.168.122.248/24 ipv4.gateway 192.168.122.1 ipv4.dns 192.168.122.1,8.8.8.8,4.2.2.1 ipv4.dns-search asus.net ipv4.method manual
nmcli connection down enp1s0; nmcli connection up enp1s0
nmcli d show
dnf -y upgrade
# Instalar terraform
dnf install -y dnf-plugins-core
dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
dnf install terraform
dnf install htop wget rsync
```
