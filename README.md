# 🚀 AWS EC2 Auto-Deployment using Terraform

This project demonstrates how to automate AWS infrastructure provisioning using **Terraform**.  
It deploys a complete environment on AWS including a VPC, subnets, security group, key pair, and an EC2 instance configured with user data for automatic setup.

---

## 🧠 Overview

The goal of this project is to showcase **Infrastructure as Code (IaC)** skills using Terraform by deploying an EC2 instance automatically in a secure AWS environment.

**Key Highlights**
- Fully automated AWS resource creation  
- Modular and reusable Terraform configuration  
- Uses user data to configure the EC2 instance on launch  
- Easily deployable and destroyable to avoid unwanted costs  

---

## 🏗️ Architecture

The Terraform configuration provisions the following resources:
- **VPC** – Custom Virtual Private Cloud for isolation  
- **Subnets** – Public subnet for EC2 deployment  
- **Internet Gateway** – To allow external access  
- **Route Table** – Routes internet traffic via the IGW  
- **Security Group** – Allows SSH and HTTP access  
- **Key Pair** – Used for secure EC2 login  
- **EC2 Instance** – Amazon Linux 2 instance launched with user-data script  

---

## ⚙️ Prerequisites

- AWS Account  
- Terraform installed (`v1.5+`)  
- AWS CLI configured with credentials (`aws configure`)  

---

## 🚀 How to Deploy

1. **Clone the repository**
   ```bash
   git clone https://github.com/<your-username>/aws-ec2-auto-deployment-terraform.git
   cd aws-ec2-auto-deployment-terraform
   ```

2. **Initialize Terraform**
   ```bash
   terraform init
   ```

3. **Preview resources to be created**
   ```bash
   terraform plan
   ```

4. **Apply configuration to deploy**
   ```bash
   terraform apply
   ```

   Type `yes` when prompted.  
   This will create all AWS resources defined in the `main.tf`.

5. **Destroy resources (to avoid costs)**
   ```bash
   terraform destroy
   ```

---

## 🧩 File Structure

```
.
├── main.tf           # Main Terraform configuration file
├──resource.tf        #Provider of the project (AWS)
├── variables.tf      # Input variables 
├── user-data.sh      # Script executed during EC2 initialization
└── README.md         # Project documentation
```

---

## 📸 Sample Output

Once deployed, you’ll get:
- EC2 instance running in your AWS Console  
- Load Balancer DNS name output on the terminal  
- Web server automatically configured  

---

## 💰 Cost Control

Remember to run:
```bash
terraform destroy
```
after testing — this ensures all AWS resources are deleted and no cost is incurred.

---

## 🧑‍💻 Author

**Siddhesh Agre**  

