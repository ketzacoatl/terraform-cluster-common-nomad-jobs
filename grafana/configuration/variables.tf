variable "url" {
  description = "URL for the Grafana server"
  default = ""
}

variable "auth" {
  description = "Colon separated authentication string for the Grafana server user:pass"
  default = "admin:admin"
}

variable "orgs" {
  description = "List of organizations with fields: name, admin_user, admins, editors, viewers"
  default = []
  type = "list"
}

variable "orgs_admins" {
  description = "List of organizations with fields: name, admin_user, admins, editors, viewers"
  default = []
  type = "list"
}

variable "orgs_editors" {
  description = "List of organizations with fields: name, admin_user, admins, editors, viewers"
  default = []
  type = "list"
}

variable "orgs_viewers" {
  description = "List of organizations with fields: name, admin_user, admins, editors, viewers"
  default = []
  type = "list"
}

variable "data_sources" {
  description = "List of data sources (backends) with fields: type, name, url, is_default"
  default = []
  type = "list"
}

variable "dashboards" {
  description = "List of dashboard configurations with fields: file, depends_on_data_source"
  default = []
  type = "list"
}

variable "alerts" {
  description = "List of alert configurations with fields: name, type, is_default, settings (as per configuration type)"
  default = []
  type = "list"
}
