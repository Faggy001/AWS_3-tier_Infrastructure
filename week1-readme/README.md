✅WEEK 1 MENTORSHIP PROJECT BY GROUP B TEAM

✅GROUP B TEAM: Fagoroye Sanumi O.
               &  Lawal Jonathan

✏️TOPIC: Deploy a Secure 3-tier Infrastructure on AWS using Terraform

📘SCOPE: We'll be launching two EC2 instances: one in a public subnet and the other in a private subnet. The EC2 instance in the public subnet will have a public IP address, allowing it to access the internet—provided the VPC is configured with an internet gateway and an appropriate route is set from the subnet to the gateway.

The private EC2 instance, on the other hand, will not have a public IP, keeping it isolated from direct internet access. However, it still needs internet connectivity for tasks like downloading security patches. To enable this, we'll set up a NAT gateway.

The NAT gateway will reside in the public subnet and will be associated with an Elastic IP (a static IP address). We'll then update the route table for the private subnet to direct traffic through the NAT gateway. This allows the private EC2 instance to access the internet securely for updates and software installations

3-tier-Architecture
![Architecture](Ec2/GroupB-Architecture.png)
✏️Creating a three–tier architecture on AWS involves setting up three layers: a Web layer, an Application layer, and a Database layer.

EXPLANATION OF EACH TERRAFORM RESOURCE USED:
✏️Terraform Resource Documentation
📌Resource: aws_vpc
  Purpose: Creates a Virtual Private Cloud (VPC) to isolate your network environment in AWS.

Key Arguments:
cidr_block= The IPv4 CIDR block for the VPC.
enable_dns_support= Enables DNS support in the VPC.
enable_dns_hostnames= Enables DNS hostnames in the VPC.

This VPC forms the basis of your network, allowing you to create subnets, gateways, and control routing.
![VPC](<Ec2/Images/Screenshot 2025-05-21 122636.png>)

🔹Resource: aws_subnet
  Purpose: Creates a subnet within a VPC to divide the network into smaller segments.

Key Arguments:
vpc_id — The VPC ID where the subnet will be created.
cidr_block — The CIDR block of the subnet.
availability_zone — The AWS Availability Zone for the subnet.
![Subnet](<Ec2/Images/Screenshot 2025-05-21 122618.png>)

📌Resource: aws_internet_gateway
  Purpose: Creates an Internet Gateway to enable internet access for resources inside the VPC.
![Internet_gateway](<Ec2/Images/Screenshot 2025-05-21 122714.png>)

🔹Resource: aws_route_table
Purpose: A route table contains a set of rules (routes) that determine how network traffic is directed within your VPC. Each subnet must be associated with one route table, which controls how traffic leaving the subnet is routed.
![route_table](<Ec2/Images/Screenshot 2025-05-21 122657.png>) 

📌Resource: aws_security_group
Purpose: Controls inbound and outbound traffic for your instances (like a virtual firewall).

Key Arguments:
vpc_id — The VPC ID to which the security group belongs.
ingress — Rules to allow inbound traffic.
egress — Rules to allow outbound traffic.
![Security_group](<Ec2/Images/Screenshot 2025-05-21 122754.png>)

🔹Resource: aws_instance
Purpose: Launches an EC2 instance.
Key Arguments:
ami — The Amazon Machine Image ID.
instance_type — The EC2 instance type.
subnet_id — The subnet where the instance is launched.
security_groups or vpc_security_group_ids - Security groups attached.
![Ec2](<Ec2/Images/Screenshot 2025-05-21 123012.png>)

📌Resource: aws_network_acl
Purpose: Network ACLs are stateless firewalls that control inbound and outbound traffic at the subnet level in your VPC. Unlike security groups (which are stateful and operate at the instance level), NACLs operate on the subnet and require explicit rules for both inbound and outbound traffic.
![Nacls](<Ec2/Images/Screenshot 2025-05-21 122835.png>)

🔹Resource: aws_network_acl_association
Purpose: Associates the NACL with a subnet. NACLs is used for subnet-level traffic filtering, good for an extra layer of security or controlling traffic flow between subnets.

📌provider
Purpose: A provider is a plugin that Terraform uses to interact with cloud platforms or services, like AWS, Azure, Google Cloud, or others. It defines the infrastructure API endpoints, authentication, and how Terraform talks to those services.

🔹output
Purpose:Outputs allow you to extract and display useful information from your Terraform state after running terraform apply. Outputs are helpful to share information between configurations or just to display things like IP addresses, IDs, or DNS names.

📌Resource: aws_nat_gateway
The NAT Gateway enables instances in a private subnet to access the internet (e.g., for updates or external APIs), while preventing inbound traffic from the internet.
![Nat_gateway](<Ec2/Images/Screenshot 2025-05-21 122736.png>)

 NAT Gateway + Route Tables + Internet Gateway
This configuration enables private subnets to access the internet through a NAT Gateway, while public subnets access the internet directly via an Internet Gateway.

🧱 Resources
aws_nat_gateway.public: NAT Gateway deployed in public subnet.

aws_route_table.public: Public route table for web-tier resources.

aws_route_table.private: Private route table for app/DB tiers.

aws_route.private-internet_out: Private → Internet via NAT.

aws_route.public_internet_access: Public → Internet via IGW.

aws_route_table_association.*: Associates subnets with the correct route table.

📡 Network Flow
Public subnet traffic: 0.0.0.0/0 → Internet Gateway

Private subnet traffic: 0.0.0.0/0 → NAT Gateway → IGW. #For testing Environment

📌resource "aws_s3_bucket" "terraform_state"
This defines an Amazon S3 bucket, which is used to store the Terraform remote state file.

Key Arguments:
bucket: The name of the S3 bucket.
versioning.enabled: Enables versioning to preserve, retrieve, and restore every version of every object stored. This is crucial for tracking state file changes over time.
lifecycle.prevent_destroy: Prevents the accidental deletion of the bucket via Terraform.

Purpose: This bucket securely stores the Terraform state file so multiple users or systems can work with the same infrastructure configuration without conflicts
![S3_bucket](<Ec2/Images/Screenshot 2025-05-21 131352.png>)

🔹resource "aws_dynamodb_table" "terraform_locks"
This defines a DynamoDB table called terraform-locks, used for state locking.

Key Arguments:
name: The name of the DynamoDB table.
billing_mode: Using PAY_PER_REQUEST avoids needing to provision read/write capacity.
hash_key: The primary key for uniquely identifying lock records. LockID is the key used by Terraform to manage locks.
attribute: Defines the schema for the primary key.

Purpose: This table is used by Terraform to implement state locking, ensuring that only one person or process can modify the state at a time, thus preventing conflicts and corruption.

resource "aws_db_instance" "postgres"
Purpose: RDS acts as the database tier where your application stores and retrieves data.
It runs in a private subnet to protect sensitive data.
The application tier communicates securely with RDS to query and manipulate data.
![Rds](<Ec2/Images/Screenshot 2025-05-21 131303.png>)

📘 Overview
In this architecture, a public EC2 instance (bastion host) is used to securely connect to a private EC2 instance within a VPC that does not have direct internet access. The bastion host acts as a jump server for secure administrative access to internal resources

☁️ Infrastructure Summary
Component	Description
VPC- Custom VPC with public and private subnets
Public Subnet-	Hosts the bastion EC2 instance
Private Subnet-	Hosts the internal EC2 instance (no public IP)
NAT Gateway-	Allows private instance outbound internet access
Internet Gateway-	Allows public instance inbound/outbound access
Security Groups-	Control SSH access between instances

🛠️ How It Works
Public EC2 (Bastion Host)

Launched in a public subnet

Has a public IP and is accessible via SSH from the internet

Security group allows SSH (port 22) from 0.0.0.0/0

Private EC2 Instance

Launched in a private subnet

No public IP address

Not directly accessible from the internet

Bastion Access Flow

![Public and Private instance](<Ec2/Images/Screenshot 2025-05-21 135329.png>)

