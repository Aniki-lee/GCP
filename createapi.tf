resource "google_vertex_ai_dataset" "dataset" {
  display_name          = "income"
  metadata_schema_uri   = "*.yaml"
  region                = "asia-southeast1"
}