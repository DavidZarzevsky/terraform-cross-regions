# Terraform Cross-Region Deployment

**Multi-Account Multi-Region Terraform Infrastructure Deployment**

This repository exemplifies the deployment and connection of AWS VPCs across AWS accounts and regions through the use of a transit gateway. This project's primary achievement is enabling SSH access to instances across VPC via a client VPN in one account, providing a secure peering. 

## Terraform

This project uses terraform to deploy infrastructure, you can download it here: https://learn.hashicorp.com/tutorials/terraform/install-cli

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | >= 4.0 |
| bash |  |


## Table of Contents

- [Introduction](#introduction)
- [Modifications](#modifications)
- [Deploy](#deploy)
- [Destroy](#destroy)
- [Features](#features)
- [Directory Structure](#directory-structure)
- [Getting Started](#getting-started)
- [Usage](#usage)

## Introduction

The **Terraform Cross-Region Deployment** project demonstrates the potential of Terraform in orchestrating complex cloud infrastructures. It showcases the ability to create and manage AWS VPCs across different accounts and regions, and establish secure communication pathways between them using a transit gateway. The ultimate goal is to enable technical enthusiasts and professionals to SSH into instances using a client VPN, promoting security, accessibility, and organizational efficiency.

## Modifications

Open the `variables.tf` file and review the configuration variables available for this project.
These variables define various settings such as regions, environment names, client certificate names, and more.
You can modify these variables to match your specific requirements.

## Configuration Variables

| Name                           | Description                                         | Type         | Default           |
|--------------------------------|-----------------------------------------------------|--------------|-------------------|
| name                           | Your name                                           | string       | "name"           |
| env                            | The environment (e.g. prod, dev, stage)            | string       | "prod"            |
| aws_src_region                 | Your source account region                         | string       | "us-east-1"       |
| aws_dst_region                 | Your destination account region                    | string       | "us-west-1"       |
| aws_src_profile                | Your source AWS profile alias                      | string       | ""                |
| aws_dst_profile                | Your destination AWS profile alias                 | string       | ""                |
| keypair_file_path              | Your keypair local path                            | string       | "/Users/israel/.ssh/il-key.pub" |
| ami                            | Source instance AMI                                | string       | "ami-02675d30b814d1daa" |
| instance_type                  | EC2 instance type                                  | string       | "t2.micro"        |
| vpc_cidr_block_src             | Source VPC CIDR block                              | string       | "10.1.0.0/16"     |
| vpc_cidr_block_dst             | Destination VPC CIDR block                         | string       | "10.2.0.0/16"     |
| src_private_subnet_cidr_block  | Source private subnet CIDR block                  | string       | "10.1.1.0/24"     |
| src_public_subnet_cidr_block   | Source public subnet CIDR block                   | string       | "10.1.0.0/24"     |
| dst_private_subnet_cidr_block  | Destination public subnet CIDR block              | string       | "10.2.1.0/24"     |
| sg_ingress_cidr_block          | Security group ingress CIDR block                 | string       | "0.0.0.0/0"       |
| sg_egress_cidr_block           | Security group egress CIDR block                  | string       | "0.0.0.0/0"       |
| client_cidr_block              | VPN client CIDR block                              | string       | "10.200.0.0/16"   |
| authorize_client_target_network_cidr | CIDR block for client target network authorization | string       | "10.0.0.0/16" |
| VPN_dns_address                | DNS IP address                                     | string       | "8.8.8.8"         |


**Configure S3 Backend:** 

If you plan to use remote state storage with Amazon S3, open the backend.tf file and update the configuration for the S3 backend. Replace the placeholders with your actual bucket name and key prefix. This ensures that your Terraform state is stored remotely.
If you are using other remote state storage edit the file accordingly.
```hcl
# backend.tf
terraform {
  backend "s3" {
    bucket         = "your-bucket-name"
    key            = "your/key/prefix"
    region         = "your-region"
    encrypt        = true
    profile        = "your-aws-profile"
  }
}
```

### Outputs

You will be presented with the public and private IPs of the EC2 instances.
Use them to SSH into the EC2 instances.

## Deploy

**Clone the Repository:** Clone this repository to your local machine using `git clone [repository-url]`.

To deploy the infrastructure, follow these steps:

1. Run the next command in your terminal
```sh
cd ${path to terraform-cross-regions directory}
terraform init
chmod u+x modules/scripts/*
terraform plan
terraform apply
```

2. Download AWS Client VPN for Desktop:

   https://aws.amazon.com/vpn/client-vpn-download/

3. Add a new profile using the .ovpn file created by the script (located in the project directory)

4. Connect to the new profile

5. SSH to the source account EC2 instance using his private IP.

   In order to SSH the EC2 destination account (other account, other region) 
   Run The next command:

   ```sh 
   scp -i /your/path/to/key-file /your/path/to/key-file ${EC2 OS name}@${EC2 private IP}:~/
   ```

## Destroy

To Destroy the infrastructure, follow these steps:

```sh
terraform destroy
```

## Features

- **Multi-Account, Multi-Region Deployment**: Highlighting the prowess of Terraform in managing infrastructure across distinct AWS environments.
- **Transit Gateway Architecture**: Building upon AWS Transit Gateway to facilitate communication between VPCs in multiple accounts and regions.
- **Client VPN Configuration**: Setting up a client VPN to allow secure and remote access to instances within the infrastructure.
- **Modular Design**: Organizing the project with modular configurations for enhanced readability and reusability.
- **Collaborative Infrastructure**: Empowering collaboration through the use of Infrastructure as Code principles.

## Directory Structure

<pre>
.
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
│   ├── scripts/
│   │   ├── authorize_client.sh
│   │   ├── create_client.sh
│   │   ├── getVPN.sh
│   │   ├── prepare_easyrsa.sh
│   │   ├── serverData.tpl
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
├── README.md
├── backend.tf
├── main.tf
├── tf.gitignore
├── serverData.tpl
├── variables.tf
</pre>

## Getting Started

follow these steps:

1. **Clone the Repository**: Clone this repository to your local environment.
2. **Configuration**: Modify `variables.tf` and other configuration files to tailor them to your specific environment.
3. **Initialize Terraform**: Run `terraform init` to prepare the working directory.
4. **Deploy**: Execute `terraform apply` to initiate the infrastructure deployment.

## Usage

Upon successful deployment, you'll gain the capability to SSH into instances using private IP addresses via the client VPN connection, offering an effective means of secure access to your infrastructure.

---

Utilizing Terraform's capabilities,this project aims to illustrate how to architect, deploy, and manage multi-account, multi-region infrastructure in the cloud.
Special thanks to Moshe Avni.
