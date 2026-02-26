# Демонстрационный ресурс для Задания 3
resource "local_file" "demo" {
  content  = "Demo file for Terraform state operations"
  filename = "${path.module}/demo.txt"
}

# Демонстрационный вывод
output "demo_content" {
  value = local_file.demo.content
}
