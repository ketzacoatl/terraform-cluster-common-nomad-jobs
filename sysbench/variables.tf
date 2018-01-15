variable "job_name" {
  description = "globally unique name for this job"
  type        = "string"
  default     = "sysbench"
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

variable "image_tag" {
  description = "image tag for container"
  default     = "1.0"
}

variable "cpu_limit" {
  description = "CPU resource limit"
  default     = "740"
}

variable "mem_limit" {
  description = "Memory resource limit"
  default     = "400"
}

variable "net_limit" {
  description = "Network resource limit"
  default     = "1"
}
