provider "aws" {
   region                  = "eu-central-1"
   shared_credentials_file = "/home/wlados/.aws/credentials"   
}

variable "private_key" {
  default = "aws_key"
}

resource "aws_instance" "ec2_hw9" {
    ami                    = "ami-0767046d1677be5a0"  
    instance_type          = "t2.micro" 
    key_name               = "aws_key"
    vpc_security_group_ids = [aws_security_group.main.id]

    tags = {
      Name = "hw9"
    }
#####
    provisioner "remote-exec" {
      inline = [
        "echo '##### ##### build connection for Ansible ##### #####'"
      ]
    }

    connection {
      host = self.public_ip
      type = "ssh"
      user = "ubuntu"
      private_key = file("./aws_key")
    }

    provisioner "local-exec" {
      command = "echo ${aws_instance.ec2_hw9.public_ip} > /tmp/file-ip && ansible-playbook -i '${aws_instance.ec2_hw9.public_ip}', --private-key '${var.private_key}' main.yaml"
    }
#####
}

resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = [ "0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0",]
      description      = "for Nginx"
      from_port        = 443
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 443
    },  
    {  
      cidr_blocks      = ["0.0.0.0/0",]
      description      = "for Nginx"
      from_port        = 80
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 80
    },  
    {  
      cidr_blocks      = ["0.0.0.0/0",]
      description      = "for me"
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = file("./aws_key.pub")
}