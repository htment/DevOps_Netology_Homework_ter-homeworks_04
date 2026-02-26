#!/bin/bash
echo "🧹 Очистка проекта..."
terraform destroy -auto-approve
rm -rf .terraform .terraform.lock.hcl
