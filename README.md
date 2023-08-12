# terraform-cross-regions
Multi-Account Multi-Region Terraform Infrastructure Deployment

This is a Multi-Account Multi-Region Terraform Infrastructure Deployment project. This repository showcases how to deploy and connect AWS VPCs across multiple AWS accounts and regions using a transit gateway. 
The success criterion is SSH into both instances when connected to the client VPN.

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
├── scripts/
├── README.md
├── backend.tf
├── main.tf
├── tf.gitignore
├── variables.tf
</pre>

