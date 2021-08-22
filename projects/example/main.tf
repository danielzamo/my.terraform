# Add plugins
terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.10"
    }
  }
}

# Define variables
variable "VM_COUNT"{
  default = 1
  type = number
}

variable "VM_USER" {
  default = "developer"
  type = string
}

variable "VM_HOSTNAME" {
  default = "vm"
  type = string
}

variable "VM_IMG_URL" {
  default = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64.img"
#  default = "https://cloud-images.ubuntu.com/focal/current/focal-server-cloudimg-amd64-disk-kvm.img"
  type = string
}

variable "VM_IMG_FORMAT" {
  default = "qcow2"
  type = string
}

variable "VM_CIDR_RANGE" {
  default = "10.10.10.10/24"
}

# Instance the provider
provider "libvirt" {
  uri = "qemu+ssh://root@192.168.122.1/system"
}

data "template_file" "network_config" {
  template = file("$(path.module)/network_config.cfg")
}

resource "libvirt_pool" "vm" {
  name = "${var.VM_HOSTNAME}_pool"
  type = "dir"
  path = "/tmp/terraform-provider-libvirt-pool-ubuntu"
} 

resource "libvirt_volume" "vm" {
  count = var.VM_COUNT
  name = "${var.VM_HOSTNAME}-${count.index}_volume.${var.VM_IMG_FORMAT}"
  pool = libvirt_pool.vm.name
  source = var.VM_IMG_URL
  format = var.VM_IMG_FORMAT
}

resource "libvirt_network" "vm_public_network" {
  name = "${var.VM_HOSTNAME}_network"
  mode = "nat"
  domain = "${var.VM_HOSTNAME}.local"
  address = ["${var.VM_CIDR_RANGE}"]
  dhcp {
    enabled = true
  }
  dns {
    enable = true
  }
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  name           = "${var.VM_HOSTNAME}_cloudinit.iso" 
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = libvirt_pool.vm.name
}

resource "" "" {
  count  = var.VM_COUNT
  name   = "${var.VM_HOSTNAME}-${count.index}"
  memory = "1024"
  vcpu   = 1
  cloudinit = "${libvirt_cloudinit_disk.cloudinit.id}"

}
