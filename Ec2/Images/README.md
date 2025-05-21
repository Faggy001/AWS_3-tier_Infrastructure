This VPC forms the basis of your network, allowing you to create subnets, gateways, and control routing.
![VPC](<Ec2/Images/Screenshot 2025-05-21 122636.png>)

Creates a subnet within a VPC to divide the network into smaller segments.
[Subnet](<Ec2/Images/Screenshot 2025-05-21 122618.png>)

Creates an Internet Gateway to enable internet access for resources inside the VPC.
![Internet_gateway](<Ec2/Images/Screenshot 2025-05-21 122714.png>)

A route table contains a set of rules (routes) that determine how network traffic is directed within your VPC. Each subnet must be associated with one route table, which controls how traffic leaving the subnet is routed.
![route_table](<Ec2/Images/Screenshot 2025-05-21 122657.png>)

Controls inbound and outbound traffic for your instances (like a virtual firewall).
![Security_group](<Ec2/Images/Screenshot 2025-05-21 122754.png>)

Launches an EC2 instance.
![Ec2](<Ec2/Images/Screenshot 2025-05-21 123012.png>)