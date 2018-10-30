variable "run" {
  description = "boolean, to run or not to run"
  default     = "true"
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

variable "version" {
  description = "version of prometheus to download, verify, and run"
  default     = "2.4.3"
}

variable "checksum" {
  description = "version of prometheus to download, verify, and run"
  default     = "sha512:2993c49b774f7be7246c669fbe4e82d2cbe348063091b2cdc827df540d00832147cf948f114278ea5d368d6dd03812cbed43888ed223f13a7846f0ef137389d5"
}

variable "cpu_limit" {
  description = "CPU resource limit"
  default     = "450"
}

variable "mem_limit" {
  description = "Memory resource limit"
  default     = "512"
}

variable "net_limit" {
  description = "Network resource limit"
  default     = "5"
}

variable "consul_server" {
  description = "Address of Consul server"
  default     = "consul.service.consul:8500"
}

variable "consul_token" {
  description = "Token to access Consul"
}
