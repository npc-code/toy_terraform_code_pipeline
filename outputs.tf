output "pipeline_s3_id" {
  value = aws_s3_bucket.codepipeline_bucket.id
}

output "pipeline_id" {
  value = aws_codepipeline.codepipeline.id
}