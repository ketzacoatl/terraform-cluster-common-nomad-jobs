variable "job_name" {
  description = "globally unique name for this job"
  type        = "string"
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

variable "version" {
  description = "version to download, verify, and run"
  default     = "1.5.3-go1.9.2"
}

variable "checksum" {
  description = "version to download, verify, and run"
  default     = "sha512:acebab491a5f5e8d25d673a9a4a4ca2f178281a6a46895359dcbd8ef53499640d46bb253f07fc8876240171d70526f7ed0f3d267b623a9f003c50e9d4fd0214c"
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

variable "consul_address" {
  description = "Consul IP Address"
}

