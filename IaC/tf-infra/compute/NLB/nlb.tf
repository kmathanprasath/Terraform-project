module "nlb" {
  source = "../../../tf-infra-modules/compute/load_balancer"

  nlb_name                   = "project-NLB"
  internal                   = false # public facing Load Balancer
  enable_deletion_protection = false
  subnet_ids = [data.terraform_remote_state.vpc.outputs.network_b_public_subnet_ids[0],
  data.terraform_remote_state.vpc.outputs.network_b_private_subnet_ids[0]]
  load_balancer_type               = "network"
  enable_cross_zone_load_balancing = true

  target_group_name = "project-app-target-group"
  target_group_port = 8084
  vpc_id            = data.terraform_remote_state.vpc.outputs.vpc_id_network_b
  target_ids = [data.terraform_remote_state.ec2.outputs.vm_app_1_instance_id,
  data.terraform_remote_state.ec2.outputs.vm_app_2_instance_id]

  listener_port = 80 # http connection

}