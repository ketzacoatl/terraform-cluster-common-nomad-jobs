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
  default     = "600"
}

variable "mem_limit" {
  description = "Memory resource limit"
  default     = "1024"
}

variable "net_limit" {
  description = "Network resource limit"
  default     = "5"
}

variable "pg_connection" {
  description = "database connection string (host/auth/etc)"
  type        = "string"
  default     = "dbname=stackage_server host=postgres.service.consul port=5432 user=postgres password=postgres"
}

variable "app_root" {
  description = "https://fqdn for stackage-server"
  type        = "string"
  default     = "stackage.service.consul"
}
