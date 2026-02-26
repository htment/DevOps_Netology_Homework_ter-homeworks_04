#!/bin/bash
echo "🚀 Запуск проекта..."
if [ ! -f terraform.tfvars ]; then
    echo "❌ Файл terraform.tfvars не найден!"
    echo "cp terraform.tfvars.example terraform.tfvars"
    exit 1
fi
terraform init
terraform plan
terraform apply -auto-approve
terraform output
