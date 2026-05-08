# १. टेराफॉर्म कॉन्फिगरेशन (AWS Provider सेट करणे)
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "ap-south-1" # मुंबई रिजन
}

# २. सिक्युरिटी ग्रुप (Jenkins आणि SSH साठी)
resource "aws_security_group" "jenkins_sg" {
  name        = "jenkins_final_sg"
  description = "Allow SSH and Jenkins access"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 8080
    to_port     = 8080
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

# ३. EC2 Instance (t3.small आणि 30GB Storage)
resource "aws_instance" "jenkins_master" {
  ami           = "ami-0dee22c13ea7a9a67" # Ubuntu 22.04
  instance_type = "t3.small"
  key_name      = "all-server-key"        # तुझी PEM फाईल

  vpc_security_group_ids = [aws_security_group.jenkins_sg.id]

  root_block_device {
    volume_size = 30
    volume_type = "gp3"
  }

  tags = {
    Name = "Jenkins-Master-Node"
  }
}

# ४. आउटपुट (IP मिळवण्यासाठी)
output "jenkins_ip" {
  value = aws_instance.jenkins_master.public_ip
}