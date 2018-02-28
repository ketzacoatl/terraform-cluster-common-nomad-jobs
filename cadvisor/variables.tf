variable "run" {
  description = "boolean, to run or not to run"
  default     = "true"
}

variable "region" {
  description = "nomad region"
  type        = "string"
}

variable "datacenters" {
  description = "nomad datacenters"
  type        = "list"
}

variable "job_name" {
  description = "globally unique name for this job"
  type        = "string"
}

variable "version" {
  description = "version to download, verify, and run"
  default     = "0.15.1"
}

variable "checksum" {
  description = "version to download, verify, and run"
  default     = "sha512:d4e52db9577a795231ce1901d3a11fefb9152848bff2283ba04b8d196461a1ddc55ec07d6a3a939b7775c7ecbb06dff4c3ff89c2cd97b89c696bef49d59f8b5a"
}

variable "cpu_limit" {
  description = "CPU resource limit"
  default     = "200"
}

variable "mem_limit" {
  description = "Memory resource limit"
  default     = "128"
}

variable "net_limit" {
  description = "Network resource limit"
  default     = "3"
}
