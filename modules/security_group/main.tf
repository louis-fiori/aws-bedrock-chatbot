#######################################
# Security Group
#######################################
resource "aws_security_group" "_" {
  name   = var.name
  vpc_id = var.vpc_id

  dynamic "egress" {
    for_each = var.cidr_egresses
    content {
      cidr_blocks = egress.value.cidr_blocks
      from_port   = egress.value.port
      to_port     = egress.value.port
      protocol    = egress.value.protocol
    }
  }

  dynamic "ingress" {
    for_each = var.cidr_ingresses
    content {
      cidr_blocks = ingress.value.cidr_blocks
      from_port   = ingress.value.port
      to_port     = ingress.value.port
      protocol    = ingress.value.protocol
    }
  }

  dynamic "ingress" {
    for_each = var.security_group_ingresses
    content {
      security_groups = ingress.value.security_groups
      from_port       = ingress.value.port
      to_port         = ingress.value.port
      protocol        = ingress.value.protocol
    }
  }
}
