resource "libvirt_volume" "ex415-client-volume" {
  name   = "libvirt_volume-qcow2-ex415_client-${count.index + 1}"
  count  = var.client_count
  pool   = var.libvirt_pool
  source = var.cloud_image
  format = "qcow2"
}

# Create the machine
resource "libvirt_domain" "ex415-client" {
  name   = "client-${count.index + 1}"
  memory = "5000"
  vcpu   = 2
  count  = var.client_count

  qemu_agent = true

  cloudinit = libvirt_cloudinit_disk.commoninit.id

  network_interface {
    bridge         = "br0"
    wait_for_lease = true
  }

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname satellite.${var.domain}"
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
    command = "sudo ansible-playbook ${var.ansible_path}/setup_clients.yml -i ${self.network_interface[0].addresses[0]},"
  }

  disk {
    volume_id = element(libvirt_volume.ex415-client-volume.*.id, count.index)
  }

  graphics {
    type        = "spice"
    listen_type = "address"
    autoport    = true
  }
}

