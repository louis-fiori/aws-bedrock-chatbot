data "aws_iam_policy_document" "assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    dynamic "principals" {
      for_each = var.service != null ? [1] : []
      content {
        type        = "Service"
        identifiers = var.service
      }
    }
  }
}

resource "aws_iam_role" "_" {
  name                = var.name
  assume_role_policy  = data.aws_iam_policy_document.assume_role.json
  managed_policy_arns = var.managed_policy_arns
}
