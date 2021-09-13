resource "google_service_account" "bucketserviceaccount" {
  account_id   = "income-bucket-access"
  display_name = "income-bucket-access"
  project      = var.project_id
}

resource "google_service_account" "marketingautomationserviceaccount" {
  account_id   = "gcp-marketing"
  display_name = "gcp-marketing"
  project      = var.project_id
}




resource "google_project_iam_custom_role" "bucketaccessrole" {
  role_id     = "bucketaccessRole"
  project = var.project_id
  title       = "Income Bucket Access"
  description = "Income Bucket Access"
  permissions = [ "bigquery.datasets.get", "bigquery.tables.create", "bigquery.tables.delete","bigquery.tables.export", "bigquery.tables.get", "bigquery.tables.getData", "bigquery.tables.list", "bigquery.tables.update", "bigquery.tables.updateData", "cloudfunctions.functions.invoke", "storage.buckets.get", "storage.objects.create", "storage.objects.delete", "storage.objects.get", "storage.objects.update", "bigquery.readsessions.create", "bigquery.readsessions.getData", "bigquery.jobs.create"]
}

locals {
   tf_incomebucketrole = google_project_iam_custom_role.bucketaccessrole.id
   tf_marketingrole = google_project_iam_custom_role.marketingrole.id
 }

resource "google_project_iam_member" "incomebucketserviceaccount" {
  project = var.project_id
  role    = local.tf_incomebucketrole
  member  = "serviceAccount:${google_service_account.bucketserviceaccount.email}"
}

resource "google_project_iam_member" "marketingserviceaccount" {
  project = var.project_id
  role    = local.tf_marketingrole
  member  = "serviceAccount:${google_service_account.marketingserviceaccount.email}"
}

module "helper" {
  source   = "../helper"
  bindings = {
    "roles/bigquery.user" = [
      "serviceAccount:g-area-tradition@production.iam.gserviceaccount.com",
      "serviceAccount:g-perfected-inquiring@production.iam.gserviceaccount.com"
    ]
  }
  mode     = "additive"
  entities = [var.project_id]
}

resource "google_project_iam_member" "project_iam_additive" {
  for_each = module.helper.set_additive
  project  = module.helper.bindings_additive[each.key].name
  role     = module.helper.bindings_additive[each.key].role
  member   = module.helper.bindings_additive[each.key].member
}