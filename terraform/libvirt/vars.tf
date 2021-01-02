variable "cloud_image" {
  default = "https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2"
}
variable "path_to_private_key" {
  default = "/home/quo/.ssh/cloud.pem"
}
variable "instance_username" {
  default = "ansible"
}
variable "libvirt_pool" {}
variable "domain" {}
variable "ansible_path" {
  default = "../../ansible"
}
variable "bridge_interface" {
  default = "br0"

}
variable "client_count" {
  default = 1
}






