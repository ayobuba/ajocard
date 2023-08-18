output "launch_template_version" {
  value = aws_launch_template.main.latest_version
}

output "launch_template_name" {
  value = aws_launch_template.main.name
}