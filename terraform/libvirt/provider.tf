# This specifies how to find our libvirt plugin as by default Terraform wants to go look for official plugins
terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.6.3"
    }
  }
  required_version = ">= v0.14.2"

}

# Specify a provider and how to connect
provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_cloudinit_disk" "commoninit" {
  name           = "commoninit_ex415.iso"
  user_data      = data.template_file.user_data.rendered
  network_config = data.template_file.network_config.rendered
  pool           = "main"
}

# Define a cloud-init template file called user_data
data "template_file" "user_data" {
  template = file("${path.module}/cloud_init.cfg")
}

# Define a cloud-init template file called network_config
data "template_file" "network_config" {
  template = file("${path.module}/network_config.cfg")
}
