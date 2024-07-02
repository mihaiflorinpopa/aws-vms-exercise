output "public_ips" {
  value = { for i in range(var.instance_count) : local.vm_names[i] => module.vm[i].public_ip }
}

output "admin_passwords" {
  value     = { for i in range(var.instance_count) : local.vm_names[i] => random_password.admin_password[i].result }
  sensitive = true
}

output "ping_status" {
  value = data.external.check_ping_results.result
}

output "ping_results" {
  value = data.external.read_log.result["content"]
}