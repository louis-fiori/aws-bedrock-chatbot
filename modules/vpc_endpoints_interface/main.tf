module "vpc_interface_endpoints_sg" {
  source = "../security_group"
  name   = "vpc-endpoints-interface-sg"
  vpc_id = var.vpc.id
  cidr_ingresses = [
    {
      cidr_blocks = [var.vpc.cidr]
      port        = 443
      protocol    = "tcp"
    }
  ]
}

resource "aws_vpc_endpoint" "interfaces" {
  count = length(var.vpc_interface_endpoints)

  vpc_id              = var.vpc.id
  service_name        = "com.amazonaws.${var.region}.${var.vpc_interface_endpoints[count.index].name}"
  vpc_endpoint_type   = "Interface"
  subnet_ids          = var.vpc.subnet_ids
  private_dns_enabled = true
  security_group_ids  = [module.vpc_interface_endpoints_sg.id]
  policy              = var.vpc_interface_endpoints[count.index].policy

  tags = {
    Name = "${var.vpc_interface_endpoints[count.index].name}"
    Type = var.vpc_interface_endpoints[count.index].name
  }
}