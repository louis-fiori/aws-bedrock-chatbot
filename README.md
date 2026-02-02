# 🧠 AWS Bedrock Chatbot - OpenWebUI + Bedrock Access Gateway

Deploy your own self-hosted ChatGPT-like interface powered by **Amazon Bedrock**, using **OpenWebUI** and **Bedrock Access Gateway**, fully containerized and deployed with **Terraform** on **AWS ECS**.

## 📝 Medium Article

Article is availaible [here](https://aws.plainenglish.io/deploying-your-own-chatgpt-on-aws-with-amazon-bedrock-and-open-webui-eb4ae62bfc74).

## 🚀 What is this project?

This repository provides everything you need to deploy a private, production-ready generative AI chatbot powered by AWS Bedrock models like Claude or Titan, using a sleek UI and without writing a single line of frontend code.

You'll get:

- 🧱 **Amazon Bedrock** access (Claude, Titan, etc.)
- 💬 **Open WebUI** for a ChatGPT-style interface
- 🔁 **Bedrock Access Gateway (BAG)** for OpenAI-compatible API access
- ☁️ Deployed on **AWS ECS Fargate**
- 🔒 **EFS, Secrets Manager, IAM, VPC, ALB**... all built-in

## 📦 Architecture Overview

![Architecture Diagram](./assets/diagram.png)

## ⚙️ Requirements

- AWS CLI configured with a profile
- AWS Account ID
- Terraform installed (`>= 1.9.5`)

## 🧪 Quick Start

```bash
git clone https://github.com/louis-fiori/aws-bedrock-chatbot.git
cd aws-bedrock-chatbot
./deploy.sh
```

Once the script is done, you'll get a DNS output. Open it in your browser, register an account, and start chatting with Bedrock LLMs!

⚠️ Note: If the Open WebUI frontend build fails (due to memory), edit the Dockerfile and replace `RUN npm run build` with `RUN NODE_OPTIONS="--max-old-space-size=4096" npm run build`

![Demonstration](./assets/demo.gif)

## 📄 License
MIT, feel free to fork and build upon it!
