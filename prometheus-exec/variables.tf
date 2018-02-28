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
  default     = "1.8.2"
}

variable "checksum" {
  description = "version of prometheus to download, verify, and run"
  default     = "sha512:f7577d48dcf5a8945b39c67edc59bf09c8420df6860206d06ef8fb43907a298ecc8f4a01bbbadc600b42bb2a8ac44622d30cfdc18e255d977c59515baf97b284"
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
