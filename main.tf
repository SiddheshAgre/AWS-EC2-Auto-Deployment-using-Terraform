resource "aws_vpc" "demo-vpc" {
  cidr_block = var.cidr
}

resource "aws_subnet" "sub1" {
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = var.sub-cidr
  availability_zone = "ap-south-1a"
  map_public_ip_on_launch = true
}

resource "aws_subnet" "sub2" {
  vpc_id = aws_vpc.demo-vpc.id
  cidr_block = var.sub-cidr1
  availability_zone = "ap-south-1b"
  map_public_ip_on_launch = true
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.demo-vpc.id
}

resource "aws_route_table" "table" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = var.route
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rta1" {
  subnet_id = aws_subnet.sub1.id
  route_table_id = aws_route_table.table.id
}

resource "aws_route_table_association" "rta2" {
  subnet_id = aws_subnet.sub2.id
  route_table_id = aws_route_table.table.id
}

resource "aws_security_group" "web-sg" {
  vpc_id = aws_vpc.demo-vpc.id

  ingress {
    description = "HTTP from VPC"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH For VPC"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags ={
    Name = "Web-Sg"
  }
}

resource "aws_s3_bucket" "example" {
  bucket = "siddhesh-terraform-project-1"
}

resource "aws_instance" "instance-1" {
  ami = var.ami-value
  instance_type = var.instance-type
  subnet_id = aws_subnet.sub1.id
  vpc_security_group_ids = [ aws_security_group.web-sg.id ]
  user_data_base64 = base64encode(file("user-data.sh"))
}

resource "aws_instance" "instance-2" {
  ami = var.ami-value
  instance_type = var.instance-type
  subnet_id = aws_subnet.sub2.id
  vpc_security_group_ids = [ aws_security_group.web-sg.id ]
   user_data_base64 = base64encode(file("user-data-2.sh"))
}

resource "aws_lb" "mylb" {
  name = "mylb"
  internal = false
  load_balancer_type = "application"

  security_groups = [ aws_security_group.web-sg.id ]
  subnets = [ aws_subnet.sub1.id, aws_subnet.sub2.id ]

  tags = {
    Name = "web"
  }
}


resource "aws_lb_target_group" "tg" {
  name = "mytg"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.demo-vpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }
}

resource "aws_lb_target_group_attachment" "tga1" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = aws_instance.instance-1.id
  port = 80
}

resource "aws_lb_target_group_attachment" "tga2" {
  target_group_arn = aws_lb_target_group.tg.arn
  target_id = aws_instance.instance-2.id
  port = 80
}

resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.mylb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type = "forward"
  }
}

output "loadbalancer" {
  value = aws_lb.mylb.dns_name
}