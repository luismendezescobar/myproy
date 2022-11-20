resource "random_string" "db_name_suffix" {
  length  = 4
  special = false
  upper   = false
}

resource "google_sql_database_instance" "mysql" {

  # Instance info
  name             = "mysql-private-${random_string.db_name_suffix.result}"
  region           = var.region
  database_version = var.mysql_database_version

  settings {

    # Region and zonal availability
    availability_type = var.mysql_availability_type
    location_preference {
      zone = var.mysql_location_preference
    }

    # Machine Type
    tier              = var.mysql_machine_type

    # Storage
    disk_size         = var.mysql_default_disk_size

    # Connections
    ip_configuration {
      ipv4_enabled        = false
      private_network     = google_compute_network.custom.id
    }

    # Backups
    backup_configuration {
      binary_log_enabled = true
      enabled = true
      start_time = "06:00"
    }
  }
  depends_on = [
    google_service_networking_connection.private-vpc-connection
  ]
}
#get the password for the database
#from the secrets section of gcp
#it needs to be created from the console prior to running
#this terraform code, you have to run the below two lines
#gcloud beta secrets create teamcity-admin-pass --locations us-east1 --replication-policy user-managed
#echo -n "Passw0rd" | gcloud beta secrets versions add teamcity-admin-pass --data-file=-


data "google_secret_manager_secret_version" "teamcity-admin-user-password" {
  secret = "teamcity-admin-pass"
}

resource "google_sql_database" "teamcity" {
  name     = "teamcity-db"
  instance = google_sql_database_instance.mysql.name
}

resource "google_sql_user" "teamcity_sql_user" {
  name = "teamcity-sql-admin"
  instance = google_sql_database_instance.mysql.name
  password = data.google_secret_manager_secret_version.wordpress-admin-user-password.secret_data
}

output "cloud-sql-connection-name" {
  value = google_sql_database_instance.mysql.connection_name
}

output "cloud-sql-instance-name" {
  value = "mysql-private-${random_string.db_name_suffix.result}"
}