provider "aws" {
  region = "us-east-1"
  alias = "test"
}

module "under_test" {
  source = "../.."
  region = "us-east-1"
  cluster_name = "under_test-cluster"
  repository_url = "under_test"
  container_name     = "under_test-container"
  subnet_ids = ["test1", "test2"]
  vpc_id = "test1"
  app_repository_name = "test_repo_name"
  app_service_name = "test-cluster"
  pipeline_name = "test-container-pipeline"
  
  bucket_name = "testtoygithubflask"
  project_name = "test-flask-codebuild"
  
  git_repository = {
    owner  = "test"
    name   = "test"
    branch = "main"
  }
  oauth_token = "test"
  
  
  providers = {
    aws = aws.test
  }

}