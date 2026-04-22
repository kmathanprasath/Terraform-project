output "bastion_instance_id" {
  description = "Instance Id of Bastion"
  value       = module.bastion.ec2_id
}

output "bastion_instance_public_ip" {
  description = "Instance Public IP of Bastion"
  value       = module.bastion.public_ip
}

output "bastion_instance_private_ip" {
  description = "Instance Private IP of Bastion"
  value       = module.bastion.private_ip
}

output "bastion_key" {
  description = "Instance Key of Bastion"
  value       = module.bastion.vm_key
  sensitive   = true
}
#--------------------------------------------------
output "connect_instance_id" {
  description = "Instance Id of vm-connect"
  value       = module.vm_connect.ec2_id
}

output "connect_instance_public_ip" {
  description = "Instance Public IP of vm-connect"
  value       = module.vm_connect.public_ip
}

output "connect_instance_private_ip" {
  description = "Instance Private IP of vm-connect"
  value       = module.vm_connect.private_ip
}

output "connect_key" {
  description = "Instance Key of vm-connect"
  value       = module.vm_connect.vm_key
  sensitive   = true
}
#--------------------------------------------------
output "nginx_instance_id" {
  description = "Instance Id of vm-nginx"
  value       = module.vm_nginx.ec2_id
}

output "nginx_instance_public_ip" {
  description = "Instance Public IP of vm-nginx"
  value       = module.vm_nginx.public_ip
}

output "nginx_instance_private_ip" {
  description = "Instance Private IP of vm-nginx"
  value       = module.vm_nginx.private_ip
}

output "nginx_key" {
  description = "Instance Key of vm-nginx"
  value       = module.vm_nginx.vm_key
  sensitive   = true
}
#-------------------------------------------
output "vm_app_1_instance_id" {
  description = "Instance Id of vm-app-1"
  value       = module.app.vm_app_1.ec2_id
}

output "vm_app_1_instance_public_ip" {
  description = "Instance Public IP of vm-app-1"
  value       = module.app.vm_app_1.public_ip
}

output "vm_app_1_instance_private_ip" {
  description = "Instance Private IP of vm-app-1"
  value       = module.app.vm_app_1.private_ip
}

output "vm_app_1_key" {
  description = "Instance Key of vm-app-1"
  value       = module.app.vm_app_1.vm_key
  sensitive   = true
}

output "vm_app_2_instance_id" {
  description = "Instance Id of vm-app-2"
  value       = module.app.vm_app_2.ec2_id
}

output "vm_app_2_instance_public_ip" {
  description = "Instance Public IP of vm-app-2"
  value       = module.app.vm_app_2.public_ip
}

output "vm_app_2_instance_private_ip" {
  description = "Instance Private IP of vm-app-2"
  value       = module.app.vm_app_2.private_ip
}

output "vm_app_2_key" {
  description = "Instance Key of vm-app-2"
  value       = module.app.vm_app_2.vm_key
  sensitive   = true
}