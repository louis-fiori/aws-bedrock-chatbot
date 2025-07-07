module "certificate" {
  source = "./modules/acm_certifcate"

  count = var.feature_toggles.enable_domain ? 1 : 0

  domain_name    = var.domain_name
  hosted_zone_id = data.aws_route53_zone.hosted_zone.zone_id
}