resource "random_password" "db_password" {
  length  = var.password_length
  special = false
}


resource "aws_db_subnet_group" "subnet_group" {
  name       = var.subnet_group_name
  subnet_ids = var.subnet_ids
  # supported_network_types = IPV4 or Dual => default -> ipv4
}


resource "aws_db_instance" "db" {
  db_name                = var.db_name                                             # name of the actaul database created
  engine                 = var.engine                                              # postgresql
  allocated_storage      = var.allocated_storage                                   # size in GB
  engine_version         = var.engine_version                                      # version
  instance_class         = var.instance_class                                      # class of db based on reqiurements
  username               = var.username                                            # master username
  password               = random_password.db_password.result                      # master password
  publicly_accessible    = var.publicly_accessible                                 # access form intenet or not
  db_subnet_group_name   = aws_db_subnet_group.subnet_group.name                   # which subnet database going to use 
  skip_final_snapshot    = var.skip_final_snapshot                                 # when destroying skip snapshot(final backup) or not 
  vpc_security_group_ids = var.create_sg ? [aws_security_group.db_sg[0].id] : null # sg for controlling access
  identifier             = var.identifier                                          # name of the rds instance
}

resource "aws_secretsmanager_secret" "db_credentials" {
  name                    = var.secret_db_name
  recovery_window_in_days = var.secret_recovery_days
}

resource "aws_secretsmanager_secret_version" "db_credentials_version" {
  secret_id = aws_secretsmanager_secret.db_credentials.id
  secret_string = jsonencode({
    DB_USER     = var.username
    DB_HOST     = aws_db_instance.db.address
    DB_PASSWORD = random_password.db_password.result
    DB_PORT     = aws_db_instance.db.port
    DB_NAME     = var.db_name
    DB_SSLMODE  = "require"
  })
}

resource "aws_security_group" "db_sg" {
  count  = var.create_sg ? 1 : 0
  name   = "${var.identifier}-sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.enable_db_access_app_1 ? [1] : []
    content {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["${var.vm_app_1_private_ip}/32"]
      description = "ssh-rule"
    }
  }

  dynamic "ingress" {
    for_each = var.enable_db_access_app_2 ? [1] : []
    content {
      from_port   = 5432
      to_port     = 5432
      protocol    = "tcp"
      cidr_blocks = ["${var.vm_app_2_private_ip}/32"]
      description = "ssh-rule"
    }
  }

  dynamic "ingress" {
    for_each = var.enable_lambda_sg ? [1] : []
    content {
      from_port       = 5432
      to_port         = 5432
      protocol        = "tcp"
      security_groups = [var.lambda_security_group]
      description     = "lambda_access_sg"
    }
  }

  tags = {
    Deployment_mode = "Terraform"
  }

}
