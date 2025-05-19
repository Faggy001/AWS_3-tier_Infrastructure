# week1

We will be deploying two ec2 instances. One will be on a public subnet, and the other on a private subnet. EC2 instance in a public subnet will have a public IP to connect to the Internet, given that you have configured an Internet gateway for VPC and created a route from the subnet to the Internet gateway.

The private EC2 instance will not have a public IP, keeping it isolated from anyone on the Internet. Even though we are not allowing it to be reachable from the Internet, we still need a way for EC2 instances to download patches. To do this, we will use the magic of the NAT gateway.

We will create a NAT gateway in the public subnet and assign it a static IP(Elastic IP). We will also configure the routes for the private subnet to talk to NAT, enabling the EC2 instance in the private subnet to download the software updates.