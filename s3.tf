# Bucket holding Open WebUI user uploads.
# The name must be globally unique, so it is prefixed with the account ID and region.
# (S3 encrypts objects with SSE-S3/AES256 by default — no extra config needed.)
resource "aws_s3_bucket" "openwebui_uploads" {
  bucket = "${var.account_id}-openwebui-uploads-${var.region}"
}

resource "aws_s3_bucket_public_access_block" "openwebui_uploads" {
  bucket = aws_s3_bucket.openwebui_uploads.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
