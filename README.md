# terraform-cross-regions
Multi-Account Multi-Region Terraform Infrastructure Deployment

Welcome to the Multi-Account Multi-Region Terraform Infrastructure Deployment project. This repository showcases how to deploy and connect infrastructure resources across multiple AWS accounts and regions using Terraform. With this project, you can deploy Virtual Private Clouds (VPCs), transit gateways, ClientVPN, and EC2 instances, allowing you to securely access instances using private IP addresses through the ClientVPN setup.

terraform-infrastructure/
├── modules/
│   ├── client_vpn/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── ec2_instance/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── peering/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── security_group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── subnet/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   ├── vpc/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
├── scripts/
├── README.md
├── backend.tf
├── main.tf
├── tf.gitignore
├── variables.tf
