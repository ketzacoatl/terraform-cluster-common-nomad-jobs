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

grafana = {
  run        = true
  node_class = "vagrant"
  cpu_limit  = "250"
  mem_limit  = "256"
  # Optional variables below
  url = "http://localhost:9090"
  auth = "admin:admin"
}

grafana_orgs = [
  {
    name = "Test Organization"
    admin_user = "admin"
  }
]
grafana_orgs_admins = [["admin@example.com"]]
grafana_orgs_editors = [
  [
    "editor-01@example.com",
    "editor-02@example.com"
  ]
]
grafana_orgs_viewers = [
  [
    "viewer-01@example.com",
    "viewer-02@example.com"
  ]
]

grafana_data_sources = [
  {
    type = "prometheus"
    name = "prometheus-x"
    url = "http://localhost:9090"
    is_default = true
  }
]

grafana_dashboards = [
  {
    file = "node-exporter-dashboard.json"
    depends_on_data_source = "prometheus-x"
  }
]

grafana_alerts = [
  {
    name = "Email that team"
    type = "email"
    is_default = false
    settings = {
      "addresses" = "foo@example.net;bar@example.net"
      "uploadImage" = "false"
    }
  }
]

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
  nomad_address = "http://10.0.2.15:4646"
}

consul-metrics = {
  run        = true
  node_class = "vagrant"
  cpu_limit  = "100"
  mem_limit  = "64"
}

statsd-metrics = {
  run        = true
  node_class = "vagrant"
  cpu_limit  = "100"
  mem_limit  = "64"
}
