resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

resource "aws_key_pair" "ec2_key" {
  key_name   = "${var.key_name}-key"
  public_key = tls_private_key.key.public_key_openssh
}


resource "aws_instance" "ec2" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  key_name                    = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids      = [aws_security_group.ec2_sg[0].id]
  associate_public_ip_address = var.associate_public_ip_address
  iam_instance_profile        = var.create_ec2_role ? aws_iam_instance_profile.ec2_instance_profile[0].name : null

  user_data = var.enable_user_data ? var.user_data : null

  tags = var.tags
}

resource "null_resource" "file_provision" {
  count = var.enable_file_provisioner ? 1 : 0

  provisioner "file" {
    source      = var.source_file
    destination = var.file_destination

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.key.private_key_pem
      host        = var.use_public_ip ? aws_instance.ec2.public_ip : aws_instance.ec2.private_ip

      bastion_host        = var.bastion_host
      bastion_user        = "ec2-user"
      bastion_private_key = var.bastion_key_content
      bastion_port        = 22
      timeout             = "3m"
    }
  }
}

resource "null_resource" "remote_exec" {
  count = var.enable_remote_exec ? 1 : 0

  provisioner "remote-exec" {
    inline = var.remote_exec_commands

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = tls_private_key.key.private_key_pem
      host        = var.use_public_ip ? aws_instance.ec2.public_ip : aws_instance.ec2.private_ip

      bastion_host        = var.bastion_host
      bastion_user        = "ec2-user"
      bastion_private_key = var.bastion_key_content
      timeout             = "3m"
    }
  }

  depends_on = [aws_instance.ec2, null_resource.file_provision]
}

resource "null_resource" "local_exec" {
  count = var.enable_local_exec ? 1 : 0

  provisioner "local-exec" {
    command = join(" && ", var.local_exec_commands)
  }
}

resource "aws_iam_role" "ec2_exec" {
  count = var.create_ec2_role ? 1 : 0
  name  = var.key_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect = "Allow"
      Principal = {
        Service = "ec2.amazonaws.com"
      }
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "secrets_manager_rw_policy" {
  count      = var.create_ec2_role ? 1 : 0
  role       = aws_iam_role.ec2_exec[count.index].name
  policy_arn = "arn:aws:iam::aws:policy/SecretsManagerReadWrite"
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  count = var.create_ec2_role ? 1 : 0
  name  = "${var.key_name}_profile"
  role  = aws_iam_role.ec2_exec[count.index].name
}

resource "aws_security_group" "ec2_sg" {
  count  = var.create_sg ? 1 : 0
  name   = "${var.key_name}-sg"
  vpc_id = var.vpc_id

  dynamic "ingress" {
    for_each = var.enable_bastion_ssh ? [1] : []
    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [var.user_ip]
      description = "ssh-rule"
    }
  }

  dynamic "egress" {
    for_each = var.enable_default_egress ? [1] : []
    content {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      description = "default egress-rule"
    }
  }

  dynamic "ingress" {
    for_each = var.enable_ssh ? [1] : []
    content {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = [var.sg_ssh_cidr]
      description = "ssh-rule"
    }
  }

  dynamic "egress" {
    for_each = var.enable_vpc_peering_sg ? [1] : []
    content {
      from_port   = 0
      to_port     = 65535
      protocol    = "tcp"
      cidr_blocks = [var.app_peer_cidr]
      description = "vpc-peering"
    }
  }

  dynamic "ingress" {
    for_each = var.enable_nginx_http ? [1] : []
    content {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = [var.user_ip]
      description = "user-http-ngninx"
    }
  }

  dynamic "ingress" {
    for_each = var.enable_app_http ? [1] : []
    content {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "http-app"
    }
  }

  dynamic "ingress" {
    for_each = var.enable_app_listen_port ? [1] : []
    content {
      from_port   = 8084
      to_port     = 8084
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
      description = "app-listening-port"
    }
  }


  tags = {
    Name            = "${var.key_name}-sg"
    Deployment_mode = "Terraform"
  }
}

