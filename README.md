Week 1
We'll be launching two EC2 instances: one in a public subnet and the other in a private subnet. The EC2 instance in the public subnet will have a public IP address, allowing it to access the internet—provided the VPC is configured with an internet gateway and an appropriate route is set from the subnet to the gateway.

The private EC2 instance, on the other hand, will not have a public IP, keeping it isolated from direct internet access. However, it still needs internet connectivity for tasks like downloading security patches. To enable this, we'll set up a NAT gateway.

The NAT gateway will reside in the public subnet and will be associated with an Elastic IP (a static IP address). We'll then update the route table for the private subnet to direct traffic through the NAT gateway. This allows the private EC2 instance to access the internet securely for updates and software installations

3-tier-Architecture
![Architecture](Ec2/GroupB-Architecture.png)
