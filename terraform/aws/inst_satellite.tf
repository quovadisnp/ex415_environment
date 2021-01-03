resource "aws_instance" "ex415-satellite" {
  ami           = var.region_ami[var.aws_region]
  instance_type = var.instance_types["satellite"]
  tags = {
    "Name" = "satellite.${var.domain}"
  }
  key_name        = var.key_name
  security_groups = ["ssh", "http", "https"]

  provisioner "remote-exec" {
    inline = [
      "sudo hostnamectl set-hostname satellite.${var.domain}"
    ]

    connection {
      host        = coalesce(self.public_ip, self.private_ip)
      type        = "ssh"
      user        = "centos"
      private_key = file(var.path_to_private_key)
    }
  }

  provisioner "local-exec" {
    command = "export ANSIBLE_PRIVATE_KEY_FILE='${var.path_to_private_key}' && ansible-playbook ${var.ansible_path}/setup_satellite.yml -i ${self.public_ip},"

  }
}

