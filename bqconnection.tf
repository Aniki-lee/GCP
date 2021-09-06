resource "google_sql_database_instance" "instance" {
    provider         = google
    name             = "my-database-instance"
    database_version = ""
    region           = "asia-southeast1"
    settings {
        tier = "db-f1-micro"
    }

   
}

resource "google_sql_database" "db" {
    provider = google
    instance = google_sql_database_instance.instance.name
    name     = "db"
}

resource "random_password" "pwd" {
    length = ""
    special = ""
}

resource "google_sql_user" "user" {
    provider = google
    name = "user"
    instance = google_sql_database_instance.instance.name
    password = random_password.pwd.result
}

resource "google_bigquery_connection" "connection" {
    provider      = google
    friendly_name = ""
    description   = ""
    cloud_sql {
        instance_id = google_sql_database_instance.instance.connection_name
        database    = google_sql_database.db.name
        type        = ""
        credential {
          username = google_sql_user.user.name
          password = google_sql_user.user.password
        }
    }
}