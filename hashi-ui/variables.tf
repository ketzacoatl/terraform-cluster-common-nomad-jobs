variable "job_name" {
  description = "globally unique name for this job"
  type        = "string"
  default     = "hashi-ui"
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
  default     = "512"
}

variable "net_limit" {
  description = "Network resource limit"
  default     = "5"
}

variable "nomad_enable" {
  description = "enable or not NOMAD_ENABLE environment variable"
  default     = 1
}

variable "nomad_address" {
  description = "Nomad address to use"
  default     = "http://http.nomad.service.consul:4646"
}
