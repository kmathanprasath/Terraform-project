module "vm_nginx" {
  source = "../../tf-infra-modules/compute/ec2"

  instance_type               = "t2.micro"
  ami_id                      = data.aws_ami.amzlinux.id
  subnet_id                   = data.terraform_remote_state.vpc.outputs.network_a_public_subnet_ids[0]
  tags                        = { Name = "vm_nginx", Deployment_mode = "Terraform" }
  associate_public_ip_address = true
  key_name                    = "vm_nginx"
  enable_user_data            = false
  user_data                   = ""
  use_public_ip               = true

  enable_file_provisioner = false
  source_file             = " "
  file_destination        = " "

  enable_remote_exec = true
  remote_exec_commands = [
    "sudo yum update -y",
    "sudo yum install nginx -y",
    "sudo systemctl start nginx",
    "sudo systemctl enable nginx"
  ]

  enable_local_exec     = false
  local_exec_commands   = []
  create_ec2_role       = false
  create_sg             = true
  vpc_id                = data.terraform_remote_state.vpc.outputs.vpc_id_network_a
  enable_bastion_ssh    = true
  user_ip               = "${chomp(data.http.my_ip.response_body)}/32"
  enable_nginx_http     = true
  enable_default_egress = true
}

module "bastion" {
  source = "../../tf-infra-modules/compute/ec2"

  instance_type               = "t2.micro"
  ami_id                      = data.aws_ami.amzlinux.id
  subnet_id                   = data.terraform_remote_state.vpc.outputs.network_b_public_subnet_ids[0]
  tags                        = { Name = "bastion", Deployment_mode = "Terraform" }
  associate_public_ip_address = true
  key_name                    = "bastion"

  use_public_ip           = true
  enable_user_data        = false
  user_data               = ""
  enable_file_provisioner = false
  source_file             = ""
  file_destination        = ""
  enable_remote_exec      = false
  remote_exec_commands    = []
  enable_local_exec       = false
  local_exec_commands     = []
  create_ec2_role         = false
  create_sg               = true
  vpc_id                  = data.terraform_remote_state.vpc.outputs.vpc_id_network_b
  enable_bastion_ssh      = true
  user_ip                 = "${chomp(data.http.my_ip.response_body)}/32"
  enable_default_egress   = true
}



module "vm_connect" {
  source = "../../tf-infra-modules/compute/ec2"

  instance_type               = "t2.micro"
  ami_id                      = data.aws_ami.amzlinux.id
  subnet_id                   = data.terraform_remote_state.vpc.outputs.network_a_private_subnet_ids[0]
  tags                        = { Name = "vm_connect", Deployment_mode = "Terraform" }
  associate_public_ip_address = false
  key_name                    = "vm_connect"

  use_public_ip           = false
  enable_user_data        = false
  user_data               = ""
  enable_file_provisioner = false
  source_file             = ""
  file_destination        = ""
  enable_remote_exec      = false
  remote_exec_commands    = []
  enable_local_exec       = false
  local_exec_commands     = []
  create_ec2_role         = false
  create_sg               = true
  vpc_id                  = data.terraform_remote_state.vpc.outputs.vpc_id_network_a
  enable_ssh              = true
  sg_ssh_cidr             = data.terraform_remote_state.vpc.outputs.network_a_public_cidr_blocks[0]
  enable_vpc_peering_sg   = true
  app_peer_cidr           = data.terraform_remote_state.vpc.outputs.vpc_cidr_block_network_b
}

module "app" {
  depends_on                  = [module.bastion]
  source                      = "../../tf-infra-modules/compute/ec2"
  for_each                    = var.app
  ami_id                      = data.aws_ami.amzlinux.id
  instance_type               = "t3.medium"
  subnet_id                   = data.terraform_remote_state.vpc.outputs.network_b_private_subnet_ids[0]
  tags                        = each.value.tags
  associate_public_ip_address = false
  key_name                    = each.value.key_name
  enable_user_data            = true
  user_data                   = <<-EOF
 #!/bin/bash
  set -e

  # Update the system
  sudo yum update -y

  # Install PostgreSQL
  sudo yum install -y postgresql15

  # Install Go
  wget https://golang.org/dl/go1.22.5.linux-amd64.tar.gz
  sudo tar -C /usr/local -xzf go1.22.5.linux-amd64.tar.gz

  # Set up Go environment variables
  echo 'export PATH=$PATH:/usr/local/go/bin' | sudo tee /etc/profile.d/go.sh
  sudo chmod +x /etc/profile.d/go.sh

EOF
  use_public_ip               = false
  enable_file_provisioner     = true
  source_file                 = "app/student_app/"
  file_destination            = "/home/ec2-user"
  enable_remote_exec          = each.value.enable_remote_exec
  remote_exec_commands = [
    "go build -o myapp main.go",
    "echo '[Unit]' | sudo tee /etc/systemd/system/myapp.service",
    "echo 'Description=My Go Application' | sudo tee -a /etc/systemd/system/myapp.service",
    "echo 'After=network.target' | sudo tee -a /etc/systemd/system/myapp.service",
    "echo '[Service]' | sudo tee -a /etc/systemd/system/myapp.service",
    "echo 'Type=simple' | sudo tee -a /etc/systemd/system/myapp.service",
    "echo 'WorkingDirectory=/home/ec2-user' | sudo tee -a /etc/systemd/system/myapp.service",
    "echo 'ExecStart=/home/ec2-user/myapp' | sudo tee -a /etc/systemd/system/myapp.service",
    "echo 'Restart=always' | sudo tee -a /etc/systemd/system/myapp.service",
    "echo 'User=ec2-user' | sudo tee -a /etc/systemd/system/myapp.service",
    "echo '[Install]' | sudo tee -a /etc/systemd/system/myapp.service",
    "echo 'WantedBy=multi-user.target' | sudo tee -a /etc/systemd/system/myapp.service",
    "sudo systemctl daemon-reload",
    "sudo systemctl start myapp",
    "sudo systemctl enable myapp",
    "echo 'Application started! Check myapp.log for output.'"
  ]
  enable_local_exec   = false
  local_exec_commands = []
  bastion_host        = module.bastion.public_ip
  bastion_key_content = module.bastion.vm_key

  create_ec2_role        = true
  create_sg              = true
  vpc_id                 = data.terraform_remote_state.vpc.outputs.vpc_id_network_b
  enable_ssh             = true
  sg_ssh_cidr            = data.terraform_remote_state.vpc.outputs.network_b_public_cidr_blocks[0]
  enable_app_http        = true
  enable_app_listen_port = true
  enable_default_egress  = true

}