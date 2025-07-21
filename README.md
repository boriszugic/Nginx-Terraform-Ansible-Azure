# 🚀 Nginx Deployment to Azure VM with Terraform & Ansible

This project automates the provisioning of an Azure Virtual Machine using **Terraform**, and then configures it with **Ansible** to serve a custom static web page using **Nginx**.

---

## 🧰 Prerequisites

- Terraform
- Ansible
- Logged into Azure from console
- SSH key pair

---

## 🚀 How to Use

### 1. Clone the repo

### 2. Deploy infrastructure with Terraform

```bash
cd infra
terraform init
terraform apply
```
This will:
- Create a resource group
- Create a Vnet, subnet inside the created Vnet, NIC, and NSG with allow http and ssh rules on the subnet
- Deploy a VM and public IP
- Write the VM's IP and hostname to Ansible's inventory file

### 3. Configure the server with Ansible

```bash
cd ../ansible
ansible-playbook -i inventory playbook.yml --ssh-extra-args='-o StrictHostKeyChecking=no'
```
This will:
- Install Nginx
- Replace the default page with a custom one
- Restart Nginx for changes to take effect

---

## 🙌 Credits
Part of the **3 Things DevOps** (https://www.linkedin.com/newsletters/7315967826320588801/) series 🛠️
