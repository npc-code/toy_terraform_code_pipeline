resource "aws_codepipeline" "codepipeline" {
  name     = var.pipeline_name
  role_arn = aws_iam_role.codepipeline_role.arn

  artifact_store {
    location = aws_s3_bucket.codepipeline_bucket.bucket
    type     = "S3"

  }
  
  stage {
      name = "Source"

      action {
        name             = "Source"
        category         = "Source"
        owner            = "ThirdParty"
        provider         = "GitHub"
        version          = "1"
        output_artifacts = ["source"]

        configuration = {
          Owner  = var.git_repository["owner"]
          Repo   = var.git_repository["name"]
          Branch = var.git_repository["branch"]
          OAuthToken = var.oauth_token
        }
      }
    }

    stage {
      name = "Build"

      action {
        name             = "Build"
        category         = "Build"
        owner            = "AWS"
        provider         = "CodeBuild"
        input_artifacts  = ["source"]
        output_artifacts = ["imagedefinitions"]
        version          = "1"

        configuration = {
          ProjectName = var.project_name
        }
      }
    }

    stage {
      name = "Deploy"

      action {
        name            = "Deploy"
        category        = "Deploy"
        owner           = "AWS"
        provider        = "ECS"
        input_artifacts = ["imagedefinitions"]
        version         = "1"
        
        configuration = {
          ClusterName = var.cluster_name
          ServiceName = var.app_service_name
          FileName    = "imagedefinitions.json"
        }
      }
    }
  }
  
  resource "aws_s3_bucket" "codepipeline_bucket" {
    #bucket = var.bucket_name
    bucket_prefix = var.bucket_name
    acl    = "private"
    force_destroy = true
  }

  data "template_file" "codepipeline_policy" {
    template = file("${path.module}/templates/codepipeline_policy.json")
        vars = {
             aws_s3_bucket_arn = aws_s3_bucket.codepipeline_bucket.arn
        }
    }
    
  resource "aws_iam_role" "codepipeline_role" {
    name = "test-role"
    assume_role_policy = file("${path.module}/templates/codepipeline_role.json")
  }
  
  resource "aws_iam_role_policy" "codepipeline_policy" {
    name = "codepipeline_policy"
    role = aws_iam_role.codepipeline_role.id

    policy = data.template_file.codepipeline_policy.rendered 
  }
