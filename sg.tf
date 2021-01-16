//################################
//## Master Security Groups     ##
//################################
//resource "aws_security_group" "lb_group" {
//  name        = "Load-Balancer-SG"
//  description = "Allow 443 and traffic to Jenkins SG"
//  vpc_id      = aws_vpc.vpc_master.id
//
//  ingress {
//    from_port   = 443
//    protocol    = "TCP"
//    to_port     = 443
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//
//  ingress {
//    from_port   = 80
//    protocol    = "TCP"
//    to_port     = 80
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//
//
//  egress {
//    from_port   = 0
//    protocol    = "-1"
//    to_port     = 0
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//}
//
//resource "aws_security_group" "jenkins_group" {
//  name        = "Jenkins-Master-SG-EUCentral"
//  description = "Allow TCP/8080 and 22"
//  vpc_id      = aws_vpc.vpc_master.id
//
//  ingress {
//    from_port   = 22
//    protocol    = "TCP"
//    to_port     = 22
//    cidr_blocks = ["0.0.0.0/0"]
//    //cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
//    description = "Allow 22 from our public IP"
//  }
//
//  ingress {
//    from_port       = 8080
//    protocol        = "TCP"
//    to_port         = 8080
//    security_groups = [aws_security_group.lb_group.id]
//    description     = "Allow anyone from ALB on port 8080"
//  }
//
//  ingress {
//    from_port   = 0
//    protocol    = "-1"
//    to_port     = 0
//    cidr_blocks = ["192.168.1.0/24"]
//    description = "Allow traffic from eu-west-2"
//  }
//
//
//
//  egress {
//    from_port   = 0
//    protocol    = "-1"
//    to_port     = 0
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//}
//
//
//################################
//## Worker Security Groups     ##
//################################
//
//resource "aws_security_group" "jenkins_sg_london" {
//  provider    = aws.region_worker
//  name        = "Jenkins-Worker-SG-London"
//  description = "Allow TCP/8080 and 22"
//  vpc_id      = aws_vpc.vpc_master_london.id
//
//  ingress {
//    from_port   = 22
//    protocol    = "TCP"
//    to_port     = 22
//    cidr_blocks = ["0.0.0.0/0"]
//    //cidr_blocks = ["${chomp(data.http.myip.body)}/32"]
//    description = "Allow ssh from our public IP"
//  }
//
//  ingress {
//    from_port   = 0
//    protocol    = "-1"
//    to_port     = 0
//    cidr_blocks = ["10.0.1.0/24"]
//  }
//
//
//
//  egress {
//    from_port   = 0
//    protocol    = "-1"
//    to_port     = 0
//    cidr_blocks = ["0.0.0.0/0"]
//  }
//}