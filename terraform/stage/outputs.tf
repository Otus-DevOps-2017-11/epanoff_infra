output "app_external_ip" {
  value = "${module.app.app_external_ip}"
}

output "db_external_ip" {
  value = "${module.db.db_external_ip}"
}
output "db_internal_ip" {
  value = "${module.db.db_internal_ip}"
}

# Вывод адреса лоад балансера для задания со звездочкой terraform-1
#output "lb_ip" {
#  value = "${google_compute_global_forwarding_rule.http.ip_address}"
#}

