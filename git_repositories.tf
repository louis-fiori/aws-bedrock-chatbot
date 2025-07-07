resource "null_resource" "clone_bedrock_access_gateway" {
  triggers = {
    run_once = "1"
  }

  provisioner "local-exec" {
    command = <<EOF
      if [ ! -d "assets/bedrock-access-gateway" ]; then
        git clone https://github.com/aws-samples/bedrock-access-gateway containers/bedrock-access-gateway
      else
        echo "Bedrock Access Gateway already exists, skipping clone"
      fi
    EOF
  }
}

resource "null_resource" "clone_open_webui" {
  triggers = {
    run_once = "1"
  }

  provisioner "local-exec" {
    command = <<EOF
      if [ ! -d "assets/open-webui" ]; then
        git clone https://github.com/open-webui/open-webui containers/open-webui

        # Modify Dockerfile for memory optimization (macOS sed syntax)
        sed -i '' 's/RUN npm run build/RUN NODE_OPTIONS="--max-old-space-size=4096" npm run build/' containers/open-webui/Dockerfile
      else
        echo "Open WebUI already exists, skipping clone"
      fi
    EOF
  }
}