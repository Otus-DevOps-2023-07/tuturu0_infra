#output "external_ip_address_app" {
#  value = yandex_compute_instance.app.network_interface.0.nat_ip_address
#}

output "external_ip_address_app" {
  value = [for ip in yandex_compute_instance.app.*.network_interface.0.nat_ip_address : ip]
}

