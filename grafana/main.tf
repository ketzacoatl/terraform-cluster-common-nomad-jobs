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
  jobspec = "${data.template_file.grafana.rendered}"
}
