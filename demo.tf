provider "nomad" {
  address = "${var.nomad_address}"
  region  = "${var.region}"
}

module "prometheus-exec" {
  source        = "./prometheus-exec"
  run           = "${var.prometheus["run"]}"
  region        = "${var.region}"
  datacenters   = "${var.datacenters}"
  consul_server = "${var.consul_server}"
  consul_token  = "${var.consul_token}"
  node_class    = "${var.prometheus["node_class"]}"
  cpu_limit     = "${var.prometheus["cpu_limit"]}"
  mem_limit     = "${var.prometheus["mem_limit"]}"
}

module "grafana" {
  source      = "./grafana"
  run         = "${var.grafana["run"]}"
  region      = "${var.region}"
  datacenters = "${var.datacenters}"
  node_class  = "${var.grafana["node_class"]}"
  cpu_limit   = "${var.grafana["cpu_limit"]}"
  mem_limit   = "${var.grafana["mem_limit"]}"
}

module "hashi-ui" {
  source        = "./hashi-ui"
  run           = "${var.hashi-ui["run"]}"
  region        = "${var.region}"
  datacenters   = "${var.datacenters}"
  nomad_address = "${var.nomad_address}"
  cpu_limit     = "${var.hashi-ui["cpu_limit"]}"
  mem_limit     = "${var.hashi-ui["mem_limit"]}"
}

module "cadvisor" {
  source      = "./cadvisor"
  run         = "${var.cadvisor["run"]}"
  region      = "${var.region}"
  datacenters = "${var.datacenters}"
  job_name    = "${var.cadvisor["job_name"]}"
  cpu_limit   = "${var.cadvisor["cpu_limit"]}"
  mem_limit   = "${var.cadvisor["mem_limit"]}"
}

module "node_exporter" {
  source      = "./node_exporter"
  run         = "${var.node_exporter["run"]}"
  region      = "${var.region}"
  datacenters = "${var.datacenters}"
  job_name    = "${var.node_exporter["job_name"]}"
  cpu_limit   = "${var.node_exporter["cpu_limit"]}"
  mem_limit   = "${var.node_exporter["mem_limit"]}"
}

module "consul-metrics" {
  source      = "./consul-metrics"
  run         = "${var.consul-metrics["run"]}"
  region      = "${var.region}"
  datacenters = "${var.datacenters}"
  node_class  = "${var.consul-metrics["node_class"]}"
  cpu_limit   = "${var.consul-metrics["cpu_limit"]}"
  mem_limit   = "${var.consul-metrics["mem_limit"]}"
}

module "nomad-metrics" {
  source      = "./nomad-metrics"
  run         = "${var.nomad-metrics["run"]}"
  region      = "${var.region}"
  datacenters = "${var.datacenters}"
  node_class  = "${var.nomad-metrics["node_class"]}"
  cpu_limit   = "${var.nomad-metrics["cpu_limit"]}"
  mem_limit   = "${var.nomad-metrics["mem_limit"]}"
}

variable "nomad_address" {
  description = "Address of Nomad"
  default     = "http://nomad-server.service.consul:4646"
}

variable "consul_server" {
  description = "Address of Consul server"
}

variable "consul_token" {
  description = "Token to access Consul"
}

variable "region" {
  description = "nomad region"
  type        = "string"
}

variable "datacenters" {
  description = "nomad datacenters"
  type        = "list"
}

# Prometheus
variable "prometheus" {
  description = "parameters for prometheus module"
  type        = "map"

  default = {
    run        = true
    node_class = "compute"
    cpu_limit  = "250"
    mem_limit  = "256"
  }
}

variable "grafana" {
  description = "parameters for grafana module"
  type        = "map"

  default = {
    run        = true
    node_class = "compute"
    cpu_limit  = "100"
    mem_limit  = "100"
  }
}

variable "hashi-ui" {
  description = "parameters for hashi-ui module"
  type        = "map"

  default = {
    run = true
    cpu_limit = "100"
    mem_limit = "100"
  }
}

variable "node_exporter" {
  description = "parameters for node_exporter module"
  type        = "map"

  default = {
    run      = true
    job_name = "node_exporter"
    cpu_limit = "100"
    mem_limit = "100"
  }
}

variable "cadvisor" {
  description = "parameters for cadvisor module"
  type        = "map"

  default = {
    run      = true
    job_name = "cadvisor"
    cpu_limit = "100"
    mem_limit = "100"
  }
}

variable "consul-metrics" {
  description = "parameters for consul-metrics module"
  type        = "map"

  default = {
    run        = true
    node_class = "manage"
    cpu_limit  = "100"
    mem_limit  = "100"
  }
}

variable "nomad-metrics" {
  description = "parameters for nomad-metrics module"
  type        = "map"

  default = {
    run        = true
    node_class = "manage"
    cpu_limit  = "100"
    mem_limit  = "100"
  }
}
