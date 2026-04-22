output "nlb_dns_name" {
  description = "Load Balancer DNS"
  value       = aws_lb.nlb.dns_name
}
