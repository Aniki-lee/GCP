module "gcs_buckets" {
  source  = "terraform-google-modules/cloud-storage/google"
  version = "~> x.x"
  project_id  = "<PROJECT ID>"
  names = ["first", "second"]
  prefix = "my-unique-prefix"
  set_users_roles = true
  users = ["group:users@example.com"]
  versioning = {
    first = true
  }
  bucket_users = {
    second = "user:spam@example.com,eggs@example.com"
  }
}