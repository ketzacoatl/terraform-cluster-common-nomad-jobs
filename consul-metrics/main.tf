data "template_file" "consul-metrics" {
  count    = "${var.run}"
  template = "${file("${path.module}/templates/consul-metrics.hcl")}"

  vars {
    job_name      = "${var.job_name}"
    region        = "${var.region}"
    datacenters   = "${join(",",var.datacenters)}"
    node_class    = "${var.node_class}"
    cpu_limit     = "${var.cpu_limit}"
    mem_limit     = "${var.mem_limit}"
    net_limit     = "${var.net_limit}"
    consul_server = "${var.consul_server}"
  }
}

resource "nomad_job" "consul-metrics" {
  jobspec = "${data.template_file.consul-metrics.rendered}"
}
