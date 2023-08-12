# Terraform Cross-Region Deployment

**Multi-Account Multi-Region Terraform Infrastructure Deployment**

Welcome to the **Terraform Cross-Region Deployment** project. This repository exemplifies the deployment and interconnection of AWS Virtual Private Clouds (VPCs) across multiple AWS accounts and regions through the use of a transit gateway. The primary achievement of this project is to enable seamless SSH access to instances via a client VPN in one account, providing a secure and scalable infrastructure solution.

## Table of Contents

- [Introduction](#introduction)
- [Features](#features)
- [Directory Structure](#directory-structure)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Contributing](#contributing)
- [License](#license)

## Introduction

The **Terraform Cross-Region Deployment** project demonstrates the potential of Terraform in orchestrating complex cloud infrastructures. It showcases the ability to create and manage AWS VPCs across different accounts and regions, and establish secure communication pathways between them using a transit gateway. The ultimate goal is to enable technical enthusiasts and professionals to SSH into instances using a client VPN, promoting security, accessibility, and organizational efficiency.

## Features

- **Multi-Account, Multi-Region Deployment**: Highlighting the prowess of Terraform in managing infrastructure across distinct AWS environments.
- **Transit Gateway Architecture**: Building upon AWS Transit Gateway to facilitate seamless communication between VPCs in various accounts and regions.
- **Client VPN Configuration**: Setting up a client VPN to allow secure and remote access to instances within the infrastructure.
- **Modular Design**: Organizing the project with modular configurations for enhanced readability and reusability.
- **README Visualization**: Enhancing project documentation through the inclusion of a directory structure diagram.
- **Collaborative Infrastructure**: Empowering collaboration through the use of Infrastructure as Code (IaC) principles.

## Directory Structure

The project structure reflects clarity, organization, and accessibility:

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
├── variables.tf
</pre>

## Getting Started

To embark on this journey, follow these steps:

1. **Clone the Repository**: Clone this repository to your local environment.
2. **Configuration**: Modify `variables.tf` and other configuration files to tailor them to your specific environment.
3. **Initialize Terraform**: Run `terraform init` to prepare the working directory.
4. **Deploy**: Execute `terraform apply` to initiate the infrastructure deployment.

## Usage

Upon successful deployment, you'll gain the capability to SSH into instances using private IP addresses via the client VPN connection, offering an effective means of secure access to your infrastructure.

## Contributing

Contributions are welcomed! Please consult the [Contributing Guidelines](CONTRIBUTING.md) to engage effectively.

## License

This project is licensed under the [MIT License](LICENSE), affirming its open-source and collaborative nature.

---

Utilizing Terraform's capabilities, the **Terraform Cross-Region Deployment** project aims to illustrate how to architect, deploy, and manage a sophisticated multi-account, multi-region infrastructure in the cloud. It strives to empower users to leverage cloud resources efficiently and securely.
