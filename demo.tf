
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
}

module "fabio-manage" {
  source      = "./fabio"
  job_name    = "fabio-manage"
  run         = "${var.fabio_manage["run"]}"
  node_class  = "${var.fabio_manage["node_class"]}"
  region      = "${var.region}"
  datacenters = "${var.datacenters}"
}

module "fabio-compute" {
  source      = "./fabio"
  job_name    = "fabio-compute"
  run         = "${var.fabio_compute["run"]}"
  node_class  = "${var.fabio_compute["node_class"]}"
  region      = "${var.region}"
  datacenters = "${var.datacenters}"
}

module "grafana" {
  source      = "./grafana"
  run         = "${var.grafana["run"]}"
  region      = "${var.region}"
  datacenters = "${var.datacenters}"
  node_class  = "${var.grafana["node_class"]}"
}

module "hashi-ui" {
  source        = "./hashi-ui"
  run           = "${var.hashi-ui["run"]}"
  region        = "${var.region}"
  datacenters   = "${var.datacenters}"
  nomad_address = "${var.nomad_address}"
}

module "ladder" {
  source      = "./ladder-docker"
  run         = "${var.ladder["run"]}"
  region      = "${var.region}"
  datacenters = "${var.datacenters}"
}

module "node_exporter" {
  source      = "./node_exporter"
  run         = "${var.node_exporter["run"]}"
  region      = "${var.region}"
  datacenters = "${var.datacenters}"
  job_name    = "${var.node_exporter["job_name"]}"
}

module "nomad-metrics" {
  source      = "./nomad-metrics"
  run         = "${var.nomad-metrics["run"]}"
  region      = "${var.region}"
  datacenters = "${var.datacenters}"
  node_class  = "${var.nomad-metrics["node_class"]}"
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
    run = true
  }
}

# Fabio
# Unfortunately due to how Terraform handles nested maps, this is needed
variable "fabio_manage" {
  description = "parameters for fabio-manage module"
  type        = "map"

  default = {
    run        = true
    node_class = "manage"
  }
}

variable "fabio_compute" {
  description = "parameters for fabio-compute module"
  type        = "map"

  default = {
    run        = true
    node_class = "compute"
  }
}

variable "grafana" {
  description = "parameters for grafana module"
  type        = "map"

  default = {
    run        = true
    node_class = "manage"
  }
}

variable "hashi-ui" {
  description = "parameters for hashi-ui module"
  type        = "map"

  default = {
    run = true
  }
}

variable "ladder" {
  description = "parameters for ladder module"
  type        = "map"

  default = {
    run = true
  }
}

variable "node_exporter" {
  description = "parameters for node_exporter module"
  type        = "map"

  default = {
    run      = true
    job_name = "node_exporter"
  }
}

variable "nomad-metrics" {
  description = "parameters for nomad-metrics module"
  type        = "map"

  default = {
    run        = true
    node_class = "manage"
  }
}

variable "sysbench" {
  description = "parameters for sysbench module"
  type        = "map"

  default = {
    run = true
  }
}
