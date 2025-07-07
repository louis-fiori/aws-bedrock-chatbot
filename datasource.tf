data "aws_route53_zone" "hosted_zone" {
  count = var.feature_toggles.enable_domain ? 1 : 0
  name  = "${var.domain_name}."
}