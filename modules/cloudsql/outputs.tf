output "mysql_instance_name" {
  description = "The name of the database instance"
  value       = google_sql_database_instance.mysql.name
}

output "mysql_private_ip_address" {
  description = "The private IPv4 address of the master instance."
  value       = google_sql_database_instance.mysql.private_ip_address
}