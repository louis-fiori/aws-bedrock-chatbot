resource "aws_s3_bucket" "terraform_state" {
  bucket = "${var.account_id}-terraform-state"
}