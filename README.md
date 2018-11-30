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
  url = "http://localhost:3000"
  auth = "admin:admin"
  data_source = false # Enable only after main grafana nomad job is running
  data_source_type = "prometheus"
  data_source_name = "prometheus-x"
  data_source_url = "http://localhost:9090"
  data_source_is_default = true
  dashboard = false # Enable only after main grafana nomad job is running
  alert = false # Enable only after main grafana nomad job is running
  alert_name = "Email that team"
  alert_type = "email"
  alert_is_default = false
  alert_settings_addresses = "foo@example.net;bar@example.net"
  alert_settings_uploadImage = "false"
  organization = false # Enable only after main grafana nomad job is running
  organization_name = "Test Organization"
  organization_admin_user = "admin"
  organization_create_users = true
  organization_admins = "admin@example.com"
  organization_editors = "editor-01@example.com,editor-02@example.com"
  organization_viewers = "viewer-01@example.com,viewer-02@example.com"
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
