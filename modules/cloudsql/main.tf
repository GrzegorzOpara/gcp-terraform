resource "google_sql_database_instance" "mysql" {
  name     = "${var.project_id}-db"
  region = var.region
  database_version = "MYSQL_8_0"
  
  deletion_protection=false
  
  depends_on = [var.private_vpc_connection_id]

  settings {
    tier = "db-n1-standard-1"
    disk_autoresize = true
    disk_size = 10
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = var.network_id
      enable_private_path_for_google_cloud_services = true
    }
  }
}

resource "google_sql_user" "users" {
  name     = "root"
  instance = google_sql_database_instance.mysql.name
  password = var.mysql-root-pwd
}

resource "google_sql_database" "database" {
  name     = "wordpress"
  instance = google_sql_database_instance.mysql.name
}