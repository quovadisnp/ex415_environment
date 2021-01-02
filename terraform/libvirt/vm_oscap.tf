# Create the machine volume
resource "libvirt_volume" "ex415-oscap-volume" {
  name   = "libvirt_volume-qcow2-ex415_oscap"
  pool   = var.libvirt_pool
  source = var.cloud_image
  format = "qcow2"
}

# Create the machine
resource "libvirt_domain" "ex415-oscap" {
  # Set the VM name based off of name_prefix value and current index of count
  name = "oscap.${var.domain}"

  # Satellite/Foreman require minimum 4GB
  memory = "4000"

  # Satellite/Foreman require minimum 2 CPU
  vcpu = 2

  qemu_agent = true

  # Specify the cloudinit disk to use
  cloudinit = libvirt_cloudinit_disk.commoninit.id

  # Create a network_interface using br0. Now this assumes you have a bridge and that it is called 'br0'
  network_interface {
    bridge         = var.bridge_interface
    wait_for_lease = true
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname oscap.${var.domain}"
    ]

    connection {
      host        = self.network_interface[0].addresses[0]
      type        = "ssh"
      user        = var.instance_username
      private_key = file(var.path_to_private_key)
    }
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  console {
    type        = "pty"
    target_type = "virtio"
    target_port = "1"
  }

  provisioner "local-exec" {
    command = "sudo ansible-playbook ${var.ansible_path}/setup_oscap.yml -i ${self.network_interface[0].addresses[0]},"
  }

  # Specify to attach disk that was defined in top resource block
  disk {
    volume_id = libvirt_volume.ex415-oscap-volume.id
  }

  # Specify graphics adapter/connection
  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}
