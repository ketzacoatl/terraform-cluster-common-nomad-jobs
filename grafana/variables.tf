variable "job_name" {
  description = "globally unique name for this job"
  type        = "string"
  default     = "grafana"
}

variable "node_class" {
  description = "nomad node class that should run this job"
  type        = "string"
}

variable "region" {
  description = "nomad region"
  type        = "string"
}

variable "datacenters" {
  description = "nomad datacenters"
  type        = "list"
}

variable "run" {
  description = "boolean, to run or not to run"
  default     = "true"
}

variable "cpu_limit" {
  description = "CPU resource limit"
  default     = "500"
}

variable "mem_limit" {
  description = "Memory resource limit"
  default     = "256"
}

variable "net_limit" {
  description = "Network resource limit"
  default     = "5"
}

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
}

variable "orgs_admins" {
  description = "List of organizations with fields: name, admin_user, admins, editors, viewers"
  default = []
}

variable "orgs_editors" {
  description = "List of organizations with fields: name, admin_user, admins, editors, viewers"
  default = []
}

variable "orgs_viewers" {
  description = "List of organizations with fields: name, admin_user, admins, editors, viewers"
  default = []
}

variable "data_sources" {
  description = "List of data sources (backends) with fields: type, name, url, is_default"
  default = []
}

variable "dashboards" {
  description = "List of dashboard configurations with fields: file, depends_on_data_source"
  default = []
}

variable "alerts" {
  description = "List of alert configurations with fields: name, type, is_default, settings (as per configuration type)"
  default = []
}
