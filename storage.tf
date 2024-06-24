# Local storage bucket
# This bucket is intended for local backups or snapshots
# While this backup is secure, production level services should really backup to
#  the backup account
resource "aws_s3_bucket" "local_storage" {
  bucket = "${var.project}-${var.name}-local-storage"
  tags   = {
    Environment = "${var.project}-${var.name}"
  }
}

resource "aws_s3_bucket_ownership_controls" "local_storage" {
  bucket = aws_s3_bucket.local_storage.id
  rule {
    object_ownership         = "ObjectWriter"
  }
}

resource "aws_s3_bucket_logging" "local_storage" {
  bucket = aws_s3_bucket.local_storage.id
  target_bucket = var.activity_log_bucket
  target_prefix = "${aws_s3_bucket.local_storage.id}/"
}

resource "aws_s3_bucket_acl" "local_storage" {
  bucket   = aws_s3_bucket.local_storage.bucket
  acl      = "private"
  depends_on = [aws_s3_bucket_ownership_controls.local_storage]
}

resource "aws_s3_bucket_server_side_encryption_configuration" "local_storage" {
  bucket = aws_s3_bucket.local_storage.bucket
  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.local_storage_key.arn
      sse_algorithm     = "aws:kms"
    }
    bucket_key_enabled = true
  }
}
