resource "google_compute_organization_security_policy" "policy" {
  provider = google

  display_name = "tf-income%{random_suffix}"
  parent       = "organizations/id"
}

resource "google_compute_organization_security_policy_rule" "policy" {
  provider = google

  policy_id = google_compute_organization_security_policy.policy.id
  action = "allow"

  direction = "INGRESS"
  enable_logging = true
  match {
    config {
      src_ip_ranges = ["192.168.x.x/xx", "10.0.x.x/x"]
      layer4_config {
        ip_protocol = "tcp"
        ports = ["xx"]
      }
      layer4_config {
        ip_protocol = "x"
      }
    }
  }
  priority = 100
}