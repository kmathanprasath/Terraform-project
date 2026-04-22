module "project_db" {
  source              = "../../tf-infra-modules/database"
  db_name             = "studentdb"
  engine              = "postgres"
  allocated_storage   = 20
  engine_version      = "16.2"
  instance_class      = "db.t3.micro"
  username            = "postgres"
  password_length     = 16
  publicly_accessible = false
  skip_final_snapshot = true
  subnet_ids = [
    data.terraform_remote_state.vpc.outputs.network_b_private_subnet_ids[1],
    data.terraform_remote_state.vpc.outputs.network_b_private_subnet_ids[2]
  ]
  subnet_group_name      = "app_subnet_group"
  identifier             = "project-db"
  secret_db_name         = "db_credentials"
  secret_recovery_days   = 0
  create_sg              = true
  enable_db_access_app_1 = true
  vm_app_1_private_ip    = data.terraform_remote_state.ec2.outputs.vm_app_1_instance_private_ip
  enable_db_access_app_2 = true
  vm_app_2_private_ip    = data.terraform_remote_state.ec2.outputs.vm_app_2_instance_private_ip
  vpc_id                 = data.terraform_remote_state.vpc.outputs.vpc_id_network_b
  enable_lambda_sg       = false
  lambda_security_group  = data.terraform_remote_state.lambda.outputs.lambda_security_group

}
