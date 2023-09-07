provider "aws" {
  profile = var.profile
  region  = var.region-master
  alias   = "region-master"
}
#Create VPC in us-east-1
resource "aws_vpc" "vpc_useast" {
  provider             = aws.region-master
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "master-vpc-team-city"
  }
}
#Create IGW in us-east-1
resource "aws_internet_gateway" "igw" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_useast.id
    tags = {
    Name = "igw-east-1"
  }
}
#Create route table in us-east-1
resource "aws_route_table" "internet_route" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_useast.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  lifecycle {
    ignore_changes = all
  }
  tags = {
    Name = "Master-Region-RT-east-1"
  }
}
#Overwrite default route table of VPC(Master) with our route table entries
#this one is going to replace the default route table (the one that is created when the vpc
#is created) with the one that we created in the previous step
resource "aws_main_route_table_association" "set-master-default-rt-assoc" {
  provider       = aws.region-master
  vpc_id         = aws_vpc.vpc_useast.id
  route_table_id = aws_route_table.internet_route.id
}
#Get all available AZ's in VPC for master region
data "aws_availability_zones" "azs" {
  provider = aws.region-master
  state    = "available"
}
#Create subnet # 1 in us-east-1
resource "aws_subnet" "subnet_1" {
  provider          = aws.region-master
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.vpc_useast.id
  cidr_block        = "10.0.1.0/24"
  tags = {
    Name = "subnet-1"
  }
}
#Create SG for allowing TCP/8080 from * and TCP/22 from your IP in us-east-1
resource "aws_security_group" "teamcity-sg" {
  provider    = aws.region-master
  name        = "teamcity-sg"
  description = "Allow TCP/8080 & TCP/22,8111"
  vpc_id      = aws_vpc.vpc_useast.id
  ingress {
    description = "Allow 22 from our public IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.external_ip]
  }
  ingress {
    description = "allow anyone on port 8080"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow traffic for teamcity from external ip"
    from_port   = 8111
    to_port     = 8111
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#Create SG for LB, only TCP/80,TCP/443 and access to jenkins-sg
resource "aws_security_group" "lb-sg" {
  provider    = aws.region-master
  name        = "lb-sg"
  description = "Allow 443 and traffic to Jenkins SG"
  vpc_id      = aws_vpc.vpc_useast.id
  ingress {
    description = "Allow 443 from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow 80 from anywhere for redirection"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
#####################here ends the network. starting the vm creation. #######################################
/*
If you need to generate an SSH keypair first run the following:
ssh-keygen -t rsa -b 4096
This will create a new RSA key pair with a length of 4096 bits.
You will be prompted to enter a file name to save the key pair. The default location is in your user’s home directory under the .ssh directory. You can choose a different file name or directory if you prefer.
You will be prompted to enter a passphrase for the key pair. This is optional but recommended to add an extra layer of security.
The ssh-keygen command will generate two files: a private key file and a public key file. The private key file should be kept secure and never shared with anyone. The public key file can be shared with Amazon EC2 instances to allow SSH access.
Finally, to use the key pair with an Amazon EC2 instance, you must add the public key to the instance when you configure it with Terraform.
*/

resource "aws_instance" "example_server" {
  ami                    = "ami-04e914639d0cca79a"
  subnet_id              = aws_subnet.subnet_1.id
  instance_type          = "t2.micro"
  vpc_security_group_ids = [ aws_security_group.lb-sg.id,aws_security_group.teamcity-sg.id ]

  network_interface {
    network_interface_id = "network_id_from_aws"
    device_index         = 0
  }

  root_block_device {
    volume_size = 30
    volume_type = gp2
  }

  user_data = <<EOF
    #!/bin/bash
    echo "Copying the SSH Key to the server"
    echo -e "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDZmQ4bvOTDTtsbSehf/uPSKccos1sPUJagADk4SgCpWiJ/bDGzvQ+VTbDrahf0vMYii6Y+E6y9oe8vzItrWiuWMvwf/48jnppf3ScgFoK65rdcYmjSczV7TAlNv9tikqVgjT5hMwkUeCoGbqkCNBAzcNiSpl20esTTeJzj6GHBEVLT6hs3pONT7Dh59nIZ9wZB7gXfe3/mC1hxYma8PlBbQRlTLKtaez5CS8PqkY+uDGT1sif82qcZiQU6D9d0AlQc9ROttbnQkEBlgEljtVfMzRmXMBigCW0yONissdZKXGFFp0pyB8pX2592P1H8xcc5IFe1p2VrGbF5aqRyiWac476Nu/5+4yLLuVBH0PNLbDDWFCPWCgARO/cCmu5oCQFgqwl4xKJnr2vmbsZxmV6QJjpzWYguOzkBIX/9A+dlOa3keKbGHcwskass/wSIQHrUcOtT+YLywCcdFKaaAuhVxvA7UiF6DfZQUMmBAQ70VRdzt7y4XGXrMUo8jB88D+51+Y1gOMBEeMFN3u0JiOSTT3BgAg1RzVdD/QvaxXIepGXbjjg4rN49FwwTz2Kfw3Gsz5CBTeVeGAZB7VubWUzpz4ldKhlDQeI9Phym20Y44qrdQ4k5g5thXurxVUbn3UG2qUKh04gfthV/o0Df2VlWHO8nl9vY8pLLgiEeOdSsZw== luis@EPMXGUAW2045" >> /home/ubuntu/.ssh/authorized_keys
    sudo apt-get install -y mysql-server
    EOF

  tags = {
    Name = "teamcity1"
  }
}