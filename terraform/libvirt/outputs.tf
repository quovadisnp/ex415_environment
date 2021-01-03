output "satellite_ip" {
  value = libvirt_domain.ex415-satellite.network_interface[0].addresses[0]
}

output "client_ip" {
  value = libvirt_domain.ex415-client.*.network_interface[0][0].addresses[0]
}

output "oscap_ip" {
  value = libvirt_domain.ex415-oscap.network_interface[0].addresses[0]
}
