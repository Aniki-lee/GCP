resource "google_bigquery_dataset" "dataset" {
  dataset_id                  = "example_dataset"
  friendly_name               = ""
  description                 = ""
  location                    = "SG"
  default_table_expiration_ms = ""

  labels = {
    env = "default"
  }

  access {
    role          = "USER"
    user_by_email = google_service_account.income.email
  }

  access {
    role   = "READER"
    domain = "income.com.sg"
  }
}

resource "google_service_account" "income" {
  account_id = "income"
}