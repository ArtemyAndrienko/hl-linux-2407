# Homework Terraform

### Description:
VM promotion with Terraform, initial setupusing Ansible.

### Platform
Yandex Cloud

### Prerequisites:
- Terraform and Ansible locally installed, YC cli locally installed

### Running project:
- prepare terraform.tfvars with `folder-id` and `cloud-id`
- run `export YC_TOKEN=$(yc iam create-token)`
- run tf commands:
  - `terraform init --upgrade` for initial setup
  - `terraform plan`  to verify config
  - `terraform apply --auto-approve` for promotion

Use output info to check setup