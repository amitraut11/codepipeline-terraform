resource "aws_s3_bucket" "codepipeline_artifacts" {
  bucket = "pipeline-artifacts-davo-amit-terraform"
  acl    = "private"
} 

resource "aws_s3_bucket" "codepipeline_artifacts-new" {
  bucket = "pipeline-artifacts-davo-amit-new-terraform"
  acl    = "private"
} 

resource "aws_s3_bucket" "codepipeline_artifacts-new1" {
  bucket = "pipeline-artifacts-davo-amit-new-terraform1"
  acl    = "private"
} 