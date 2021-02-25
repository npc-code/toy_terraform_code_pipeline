variable "cluster_name" {
  description = "The cluster_name"
}

variable "app_repository_name" {
  description = "ECR Repository name"
}

variable "app_service_name" {
  description = "Service name"
}

variable "git_repository" {
  type        = map(string)
  description = "ecs task environment variables"
}

variable "vpc_id" {
  description = "The VPC id"
}

variable "repository_url" {
  description = "The url of the ECR repository"
}

variable "region" {
  description = "The region to use"
  default     = "us-east-2"
}

variable "container_name" {
  description = "Container name"
  default = ""
}

variable "bucket_name" {
  description = "artifact bucket name"
  default = ""
}

variable "pipeline_name" {
    description = "the pipeline name"
}

variable "build_args" {
  type    = map(string)
  default = {}
}

variable "build_options" {
  type        = string
  default     = ""
  description = "Docker build options. ex: '-f ./build/Dockerfile' "
}

variable "project_name" {
    type = string
    default = ""
    description = "projectname for codebuild"
}

variable "oauth_token" {
    type = string
    default = ""
    description = "git oauth token to access repository from aws environment"
}
