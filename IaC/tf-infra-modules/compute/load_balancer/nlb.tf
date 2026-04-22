resource "aws_lb" "nlb" {
  name                             = var.nlb_name
  internal                         = var.internal
  load_balancer_type               = var.load_balancer_type
  enable_deletion_protection       = var.enable_deletion_protection # false -> we can able to remove the resouces in AWS API calls
  subnets                          = var.subnet_ids
  enable_cross_zone_load_balancing = var.enable_cross_zone_load_balancing


  tags = {
    Name            = var.nlb_name
    Deployment_mode = "Terraform"
  }
}

resource "aws_lb_target_group" "app_tg" {
  name     = var.target_group_name
  port     = var.target_group_port # my target type is instance or ip so port is needed
  protocol = "TCP"                 # my target is instance so it is needed, no needed for lambda functions layer-4 load balancing
  vpc_id   = var.vpc_id

  health_check {
    healthy_threshold   = 2                     # no of health checks before target marking as healthy
    interval            = 30                    # time between health checks
    timeout             = 5                     # time to wait for response
    unhealthy_threshold = 2                     # no of health checks before target marking as unhealthy
    protocol            = "TCP"                 # protocol used for health checks
    port                = var.target_group_port # target port used for health checks
  }
}

resource "aws_lb_target_group_attachment" "app_tg_attachment_vm_app" {
  count            = length(var.target_ids)
  target_group_arn = aws_lb_target_group.app_tg.arn # target group id
  target_id        = var.target_ids[count.index]    # target resource
  port             = var.target_group_port          # target port receives traffic
}


resource "aws_lb_listener" "tcp_listener" {
  load_balancer_arn = aws_lb.nlb.arn    # links the listener to my load balancer
  port              = var.listener_port # port going to listen
  protocol          = "TCP"
  default_action {
    type             = "forward" # incoming traffic should be forwared to target group
    target_group_arn = aws_lb_target_group.app_tg.arn
    #[Client] -> Port 80 -> [Load Balancer(NLB) Listener] -> [Target Group] -> Port 8084 -> [Targets (EC2/IP)]
  }
}
