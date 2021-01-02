# Working Notes

Requirements
* Must have the Terraform libvirt plugin compiled/installed: https://github.com/dmacvicar/terraform-provider-libvirt

Random Notes
* A random key is included in the repo, `cloud`. An `ansible` user is created on each VM and authorized_keys is updated to use `cloud.pem`.
* Run `terraform output` to see the IPs of each VM
* Each VM can be accessed with `ssh -i cloud.pem ansible@[ip_address]`
* Currently only supports putting VMs on a bridged interface, if bridged interface is not br0 then update terraform.tfvars and update `bridge_interface`.



- 
