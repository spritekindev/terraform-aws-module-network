##################################################################################################################
# Create an RDS encryption key for this foundation
resource "aws_kms_key" "rds_key" {
  description             = "RDS encryption key for the ${var.name} foundation"
  deletion_window_in_days = 30
}

resource "aws_kms_alias" "rds_key_alias" {
  name          = "alias/${var.name}-rds-key"
  target_key_id = aws_kms_key.rds_key.key_id
}

##################################################################################################################
# Create an S3 encryption key for this foundation local storage bucket
resource "aws_kms_key" "local_storage_key" {
  description             = "S3 encryption key for ${var.name} local storage"
  deletion_window_in_days = 30
}

resource "aws_kms_alias" "au_dev_s3_encryption_key_alias" {
  name          = "alias/${var.name}-local-storage-key"
  target_key_id = aws_kms_key.local_storage_key.key_id
}

