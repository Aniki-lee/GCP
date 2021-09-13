variable "enable_apis" {
   description = "Whether to actually enable the APIs. If false, this module is a no-op."
   default     = true
 }

variable "activate_apis" {
  description = "List of APIs to enable in the seed project."
  type        = list(string)

  default = [
    "dialogflow.googleapis.com",
    "bigquery.googleapis.com",
    "analytics.googleapis.com",
    "logging.googleapis.com",
    "secretmanager.googleapis.com",
    "maps-backend.googleapis.com",
    "cloudfunctions.googleapis.com",
    "sheets.googleapis.com",
    "cloudscheduler.googleapis.com",
    "speech.googleapis.com",
    "adsdatahub.googleapis.com",
    "bigquerydatatransfer.googleapis.com",
    "bigquerystorage.googleapis.com"
  ]
}



variable "project_id" {
  default = "devops-income-xxxxxxx"
}

variable "disable_services_on_destroy" {
  description = "Whether project services will be disabled when the resources are destroyed"
  default     = true
  type        = bool
}


variable "disable_dependent_services" {
  description = "Whether services that are enabled and which depend on this service should also be disabled when this service is destroyed."
  default     = true
  type        = bool
}


variable "income_service_account" {
  default = "devops1-income-xxxxxxx.iam.gserviceaccount.com"
  description = "Service account email of the account to impersonate to run Terraform."
  type        = string
}









variable "activate_api_identities" {
  description = <<EOF
    The list of service identities (Google Managed service account for the API) to force-create for the project (e.g. in order to grant additional roles).
    APIs in this list will automatically be appended to `activate_apis`.
    Not including the API in this list will follow the default behaviour for identity creation (which is usually when the first resource using the API is created).
    Any roles (e.g. service agent role) must be explicitly listed. See https://cloud.google.com/iam/docs/understanding-roles#service-agent-roles-roles for a list of related roles.
  EOF
  type = list(object({
    api   = string
    roles = list(string)
  }))
  default = []
}
