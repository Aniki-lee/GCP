locals {
  tf_sa = var.income_service_account
}

provider "google" {
  alias = "x"

  scopes = [
    "https://www.googleapis.com/auth/cloud-platform",
    "https://www.googleapis.com/auth/userinfo.email",
  ]
}

data "google_service_account_access_token" "default" {
  provider               = google.x
  target_service_account = local.tf_sa
  scopes                 = ["userinfo-email", "cloud-platform"]
  lifetime               = "600s"
}


provider "google" {
  access_token = data.google_service_account_access_token.default.access_token
  version      = "~> 3.xx"
}

provider "google" {
  access_token = data.google_service_account_access_token.default.access_token
  version      = "~> 3.xx"
}
