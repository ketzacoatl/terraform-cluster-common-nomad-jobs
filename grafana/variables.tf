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
  default     = "http://localhost:3000"
}

variable "auth" {
  description = "Authentication string like: <user:pass>"
  default     = "admin:admin"
}

variable "data_source" {
  description = "Data source configuration"

  default = {
    run        = false
    type       = "prometheus"
    name       = "X"
    url        = "http://localhost:9090"
    is_default = true
  }

  type = "map"
}

variable "dashboard" {
  description = "Dashboard configuration"

  default = {
    run = false
  }

  type = "map"
}

variable "alert" {
  description = "Alerts configuration"

  default = {
    run        = false
    name       = "Alert!"
    type       = "email"
    is_default = false
  }

  type = "map"
}

variable "alert_settings" {
  description = "Alerts configuration settings"

  default = {
    run = false
  }

  type = "map"
}

variable "organization" {
  description = "Organization configuration"

  default = {
    run          = false
    name         = "Test Organization"
    admin_user   = "admin"
    create_users = true
    admins       = ""
    editors      = ""
    viewers      = ""
  }

  type = "map"
}
