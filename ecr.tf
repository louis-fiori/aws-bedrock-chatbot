locals {
  bag_working_dir       = "containers/bedrock-access-gateway/src"
  openwebui_working_dir = "containers/open-webui"
  mcpo_working_dir      = "containers/mcpo"
}

# ECR Repositories
resource "aws_ecr_repository" "bag_repository" {
  name                 = "bedrock-access-gateway"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "openwebui_repository" {
  name                 = "openwebui"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

resource "aws_ecr_repository" "mcpo_repository" {
  name                 = "mcpo"
  image_tag_mutability = "MUTABLE"
  force_delete         = true

  image_scanning_configuration {
    scan_on_push = true
  }
}

# Build and push Docker images to ECR
resource "null_resource" "build_bag_image" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(local.bag_working_dir, "**") : filesha1("${local.bag_working_dir}/${f}")]))
  }

  provisioner "local-exec" {
    working_dir = local.bag_working_dir
    command     = <<EOF
        aws ecr get-login-password --region ${var.region} --profile ${var.profile} | docker login --username AWS --password-stdin ${var.account_id}.dkr.ecr.${var.region}.amazonaws.com
        docker build \
        -t ${aws_ecr_repository.bag_repository.repository_url}:latest \
        -f Dockerfile_ecs --platform=linux/arm64 . \
        && docker push ${aws_ecr_repository.bag_repository.repository_url}:latest
    EOF
  }

  depends_on = [
    aws_ecr_repository.bag_repository,
    null_resource.clone_bedrock_access_gateway
  ]
}

resource "null_resource" "build_webui_image" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(local.openwebui_working_dir, "**") : filesha1("${local.openwebui_working_dir}/${f}")]))
  }

  provisioner "local-exec" {
    working_dir = local.openwebui_working_dir
    command     = <<EOF
        aws ecr get-login-password --region ${var.region} --profile ${var.profile} | docker login --username AWS --password-stdin ${var.account_id}.dkr.ecr.${var.region}.amazonaws.com
        docker build \
        -t ${aws_ecr_repository.openwebui_repository.repository_url}:latest \
        --platform=linux/arm64 . \
        && docker push ${aws_ecr_repository.openwebui_repository.repository_url}:latest
    EOF
  }

  depends_on = [
    aws_ecr_repository.openwebui_repository,
    null_resource.clone_open_webui
  ]
}

resource "null_resource" "build_mcpo_image" {
  triggers = {
    dir_sha1 = sha1(join("", [for f in fileset(local.mcpo_working_dir, "**") : filesha1("${local.mcpo_working_dir}/${f}")]))
  }

  provisioner "local-exec" {
    working_dir = local.mcpo_working_dir
    command     = <<EOF
        aws ecr get-login-password --region ${var.region} --profile ${var.profile} | docker login --username AWS --password-stdin ${var.account_id}.dkr.ecr.${var.region}.amazonaws.com
        docker build \
        -t ${aws_ecr_repository.mcpo_repository.repository_url}:latest \
        --platform=linux/arm64 . \
        && docker push ${aws_ecr_repository.mcpo_repository.repository_url}:latest
    EOF
  }

  depends_on = [aws_ecr_repository.mcpo_repository]
}