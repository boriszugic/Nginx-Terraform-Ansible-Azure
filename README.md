# 🚀 Nginx Flask App Deployment to Azure with Terraform, Ansible & GitHub Actions
This project automates the provisioning of two Azure Virtual Machines using Terraform, configures them using Ansible, and deploys a Flask backend application via GitHub Actions. The setup includes an Nginx reverse proxy VM and a separate backend Flask app VM.

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
- Deploy 2 VMs (one for Nginx, one for Flask backend) and corresponding public IPs
- Write the VMs' IPs and hostnames to Ansible's inventory file

### 3. Configure the server with Ansible

```bash
cd ../ansible
ansible-playbook -i inventory configure-nginx-reverse-proxy.yaml --ssh-extra-args='-o StrictHostKeyChecking=no'
ansible-playbook -i inventory install_python_flask.yaml --ssh-extra-args='-o StrictHostKeyChecking=no'
```
This will:
- Install Nginx on the first VM and configure it as a reverse proxy
- Install Python and Flask on the second VM

### 4. Deploy via GitHub Actions

On each push to main, GitHub Actions will:

- Create a code artifact
- Upload the artifact to GitHub
- Copy the artifact to the backend VM
- Deploy the app using systemd

---

## 🙌 Credits
Part of the **3 Things DevOps** (https://www.linkedin.com/newsletters/7315967826320588801/) series 🛠️
