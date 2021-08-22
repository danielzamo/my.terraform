# Terraform

> Utilizando Terraform 

## Instalar Terraform en Fedora 34

```bash
sudo dnf -y upgrade
# Instalar terraform
sudo dnf install -y dnf-plugins-core
sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
sudo dnf install terraform
```

## Provision mediante KVM

### Instalar KVM

```bash
sudo dnf -y install libvirt virt-install qemu-kvm
sudo dnf -y install libvirt-devel virt-top libguestfs-tools
sudo systemctl enable --now libvirtd
```


