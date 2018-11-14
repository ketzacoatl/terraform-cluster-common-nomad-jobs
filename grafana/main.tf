data "template_file" "grafana" {
  count    = "${var.run}"
  template = "${file("$({path.module})/templates/grafana.hcl")}"

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

# module "configuration" {
#   source = "./configuration"
#   # depends_on = ["nomad_job.grafana"]
#   url = "${var.url}"
#   auth = "${var.auth}"
#   orgs = ["${var.orgs}"]
#   orgs_admins = ["${var.orgs_admins}"]
#   orgs_editors = ["${var.orgs_editors}"]
#   orgs_viewers = ["${var.orgs_viewers}"]
#   data_sources = ["${var.data_sources}"]
#   dashboards = ["${var.dashboards}"]
#   alerts = ["${var.alerts}"]
# }
