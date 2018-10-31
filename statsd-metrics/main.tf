data "template_file" "statsd-metrics" {
  count    = "${var.run}"
  template = "${file("${path.module}/templates/statsd-metrics.hcl")}"

  vars {
    job_name      = "${var.job_name}"
    region        = "${var.region}"
    datacenters   = "${join(",",var.datacenters)}"
    node_class    = "${var.node_class}"
    cpu_limit     = "${var.cpu_limit}"
    mem_limit     = "${var.mem_limit}"
    net_limit     = "${var.net_limit}"
    statsd_mapping_config = "${var.statsd_mapping_config}"
  }
}

resource "nomad_job" "statsd-metrics" {
  count   = "${var.run}"
  jobspec = "${data.template_file.statsd-metrics.rendered}"
}
