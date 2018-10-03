data "template_file" "nomad-metrics" {
  count    = "${var.run}"
  template = "${file("${path.module}/templates/nomad-metrics.hcl")}"

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

resource "nomad_job" "nomad-metrics" {
  count   = "${var.run}"
  jobspec = "${data.template_file.nomad-metrics.rendered}"
}
