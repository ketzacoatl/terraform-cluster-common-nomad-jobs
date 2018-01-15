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
