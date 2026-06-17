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
  name               = var.name
  assume_role_policy = data.aws_iam_policy_document.assume_role.json
}

# `managed_policy_arns` on aws_iam_role is deprecated; use explicit attachments.
# count (not for_each) is used because the ARNs are not known until apply.
resource "aws_iam_role_policy_attachment" "_" {
  count = length(var.managed_policy_arns)

  role       = aws_iam_role._.name
  policy_arn = var.managed_policy_arns[count.index]
}
