locals {
  domain_validation_options = tolist(aws_acm_certificate.default.domain_validation_options)
}

resource "aws_acm_certificate" "acm_certificate" {
  domain_name               = var.domain_name
  subject_alternative_names = "*.${var.domain_name}"
  validation_method         = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "validation_records" {
  count = 2 # One for the main domain and one for the wildcard subdomain

  zone_id         = var.hosted_zone_id
  name            = local.domain_validation_options[count.index]["resource_record_name"]
  type            = local.domain_validation_options[count.index]["resource_record_type"]
  records         = [local.domain_validation_options[count.index]["resource_record_value"]]
  ttl             = 60
  allow_overwrite = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate_validation" "acm_certificate_validation" {
  certificate_arn         = aws_acm_certificate.acm_certificate.arn
  validation_record_fqdns = aws_route53_record.validation_records[*].fqdn

  lifecycle {
    create_before_destroy = true
  }
}
