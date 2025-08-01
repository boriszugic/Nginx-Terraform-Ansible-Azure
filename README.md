# 🚀 Nginx Flask App Deployment to Azure with Terraform, Ansible & GitHub Actions
This project automates the provisioning of two Azure Virtual Machines using Terraform, configures them using Ansible, and deploys a Flask backend application via GitHub Actions. The setup includes an Nginx reverse proxy VM and a separate backend Flask app VM. The TLS certificate is issued by Let's Encrypt via Certbot.

---

## 🧰 Prerequisites

- Terraform
- Ansible
- Logged into Azure from console
- 2 SSH key pairs (~/.ssh/id_rsa and ~/.ssh/id_rsa_backend for Nginx VM and Flask VM respectively)
- Custom domain (for HTTPS, optional)

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
- Create a Vnet, subnet inside the created Vnet, NICs, and 2 NSGs with allow http/s rules on Nginx NSG, and allow ssh rule on both
- Deploy 2 VMs (one for Nginx, one for Flask backend) and corresponding public IPs
- Write the VMs' public IPs and hostnames to Ansible's inventory file, and backend VM's private ip to ```vars/backend-ip.yaml```

### 3. Configure the servers with Ansible

```bash
cd ../ansible
ansible-playbook -i inventory -private-key ~/.ssh/id_rsa_backend install_python_flask.yaml --ssh-extra-args='-o StrictHostKeyChecking=no'
ansible-playbook -i inventory configure-nginx-reverse-proxy.yaml --ssh-extra-args='-o StrictHostKeyChecking=no'
ansible-playbook -i inventory install_certbot_and_configure_tls.yaml --extra-vars "domain={your_domain} email={your_email}" --ssh-extra-args='-o StrictHostKeyChecking=no'
```
This will:
- Install Nginx on the first VM and configure it as a reverse proxy with TLS termination
- Install Python and Flask on the second VM

### 4. Deploy via GitHub Actions

On each push to main or manual dispatch, GitHub Actions will:

- Create a code artifact
- Upload the artifact to GitHub
- Copy the artifact to the backend VM
- Deploy the app using systemd

---

## 🙌 Credits
Part of the <a href="https://www.linkedin.com/build-relation/newsletter-follow?entityUrn=7315967826320588801" target="_blank">DevOps Starter Pack</a> series 🛠️
