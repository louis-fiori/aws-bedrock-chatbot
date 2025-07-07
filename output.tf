output "url" {
  value = var.feature_toggles.enable_domain ? "https://${var.domain_name}" : aws_lb.alb.dns_name
}
