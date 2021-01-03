# EX415 Study Environment
Generate study environment for Red Hat EX415 using Terraform/Ansible. This isn't a Q/A or Study Guide. EX415 has specific objectives that require specific infrastructure pieces to be in place in order to properly study for which includes:
* Satellite Server (in this case it's Foreman since we're using the free upstream)
* SCAP Workbench Server
* Any host to practice basic ansible playbooks/config/inventory
* Any 2 hosts to practice clevis/tang between
* Any host to practice playing with auditd
* Any host to practice playing with LUKS
* Any host to practice configure/using AIDE on

Full objective list: https://www.redhat.com/en/services/training/ex415-red-hat-certified-specialist-security-linux-exam



# Using Terraform libvirt

## Requirements
* Must have the Terraform libvirt plugin compiled/installed: https://github.com/dmacvicar/terraform-provider-libvirt
* Create `terraform.tfvars` file with the following information (this file is in .gitignore):
```
  domain              = "[fake domain name]"
  libvirt_pool        = "[an existing libvirt pool to deploy to]"
```

## Notes
* A random key is included in the repo, `cloud`. An `ansible` user is created on each VM and authorized_keys is updated to use `cloud.pem`.
* Run `terraform output` to see the IPs of each VM
* Each VM can be accessed with `ssh -i cloud.pem ansible@[ip_address]`
* Currently only supports putting VMs on a bridged interface, if bridged interface is not br0 then update terraform.tfvars and update `bridge_interface`.

## Usage
* Change directory to `terraform/libvirt`
* Run `terraform apply`

# SCAP Workbench
Launch SCAP Workbench 
* Libvirt: `ssh -i <repo_path>/ex415_environment/terraform/libvirt/cloud.pem -X ansible@[oscap_ip] 'scap-workbench'`
* AWS: `ssh -i <AWS key path> -X centos@[oscap_ip] 'scap-workbench'

# Satellite/Foreman
