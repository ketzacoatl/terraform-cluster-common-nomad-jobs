# create a list of template_file data sources with init for each instance
data "template_file" "prometheus" {
  count    = "${var.run}"
  template = "${file("${path.module}/templates/prometheus-exec.hcl")}"

  vars {
    region        = "${var.region}"
    datacenters   = "${join(",",var.datacenters)}"
    version       = "${var.version}"
    checksum      = "${var.checksum}"
    cpu_limit     = "${var.cpu_limit}"
    mem_limit     = "${var.mem_limit}"
    net_limit     = "${var.net_limit}"
    consul_server = "${var.consul_server}"
    consul_token  = "${var.consul_token}"
  }
}

resource "nomad_job" "prometheus" {
  jobspec = "${data.template_file.prometheus.rendered}"
}
