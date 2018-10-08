# `terraform-cluster-common-nomad-jobs`

### Add some `terraform.tfvars`

Example:

```
nomad_address = "http://127.0.0.1:4646"
consul_server = "10.0.2.15:8500"
consul_token = "b684a56c-cf86-443b-a48f-52056f21986f"
region = "us"
datacenters = ["vagrant"]

prometheus = {
  run        = true
  node_class = "vagrant"
  cpu_limit  = "250"
  mem_limit  = "256"
}

cadvisor = {
  run        = false
  node_class = "vagrant"
  cpu_limit  = "250"
  mem_limit  = "256"
}

grafana = {
  run        = true
  node_class = "vagrant"
  cpu_limit  = "250"
  mem_limit  = "256"
}

hashi-ui = {
  run           = true
  node_class    = "vagrant"
  cpu_limit     = "100"
  mem_limit     = "64"
  nomad_address = "http://10.0.2.15:4646"
}

nomad-metrics = {
  run        = true
  node_class = "vagrant"
  cpu_limit  = "100"
  mem_limit  = "64"
}

consul-metrics {
  run        = true
  node_class = "vagrant"
  cpu_limit  = "100"
  mem_limit  = "64"
}
```
