data "template_file" "grafana" {
  count    = "${var.run}"
  template = "${file("${path.module}/templates/grafana.hcl")}"

  vars {
    job_name    = "${var.job_name}"
    region      = "${var.region}"
    datacenters = "${join(",",var.datacenters)}"
    node_class  = "${var.node_class}"
    cpu_limit   = "${var.cpu_limit}"
    mem_limit   = "${var.mem_limit}"
    net_limit   = "${var.net_limit}"
  }
}

resource "nomad_job" "grafana" {
  count   = "${var.run}"
  jobspec = "${data.template_file.grafana.rendered}"
}

provider "grafana" {
  url  = "${var.url}"
  auth = "${var.auth}"
}

resource "grafana_data_source" "prometheus-x" {
  count      = "${var.data_source["run"]}"
  type       = "${var.data_source["type"]}"
  name       = "${var.data_source["name"]}"
  url        = "${var.data_source["url"]}"
  is_default = "${var.data_source["is_default"]}"
  depends_on = ["nomad_job.grafana"]
}

data "template_file" "grafana_dashboard" {
  count    = "${var.dashboard["run"]}"
  template = "${file("${path.module}/templates/node-exporter-dashboard.json")}"

  vars = {
    data_source = "${var.data_source["name"]}"
  }
}

resource "null_resource" "export_rendered_template" {
  count      = "${var.dashboard["run"]}"
  depends_on = ["data.template_file.grafana_dashboard"]

  provisioner "local-exec" {
    command = "cat > test_output.json <<EOL\n${data.template_file.grafana_dashboard.rendered}\nEOL"
  }
}

resource "grafana_dashboard" "node-exporter-stats" {
  count      = "${var.dashboard["run"]}"
  depends_on = ["data.template_file.grafana_dashboard"]

  # There are caveats regarding dashboard templating in Grafana
  # Please refer to the following to understand the issue
  # https://github.com/utkarshcmu/wizzy/issues/107
  # https://github.com/grafana/grafana/issues/10786
  config_json = "${data.template_file.grafana_dashboard.rendered}"
}

resource "grafana_alert_notification" "alerts" {
  depends_on = ["nomad_job.grafana"]
  count      = "${var.alert["run"]}"
  name       = "${var.alert["name"]}"
  type       = "${var.alert["type"]}"
  is_default = "${var.alert["is_default"]}"

  settings = {
    "addresses"   = "${var.alert_settings["addresses"]}"
    "uploadImage" = "${var.alert_settings["uploadImage"]}"
  }
}

resource "grafana_organization" "org" {
  depends_on   = ["nomad_job.grafana"]
  count        = "${var.organization["run"]}"
  name         = "${var.organization["name"]}"
  admin_user   = "${var.organization["admin_user"]}"
  create_users = "${var.organization["create_users"]}"
  admins       = ["${split(",", var.organization["admins"])}"]
  editors      = ["${split(",", var.organization["editors"])}"]
  viewers      = ["${split(",", var.organization["viewers"])}"]
}
