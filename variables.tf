variable "cidr" {
  description = "Variable for VPC CIDR Block"
  default = "10.0.0.0/16"
}

variable "sub-cidr" {
  description = "Varibale for Subnet CIDR Block"
  default = "10.0.0.0/24"
}

variable "sub-cidr1" {
  description = "Variable for Subnet CIDR Block"
  default = "10.0.1.0/24"
}

variable "route" {
  description = "Variable for Route Table CIDR Block"
  default = "0.0.0.0/0"
}

variable "ami-value" {
  description = "Value of AMI"
  default = "ami-02d26659fd82cf299"
}
variable "instance-type" {
  description = "Instance Type"
  default = "t2.micro"
}