data "template_file" "hashi-ui" {
  count    = "${var.run}"
  template = "${file("${path.module}/templates/hashi-ui-${var.container_engine == "docker" ? "docker" : "rkt"}.hcl")}"

  vars {
    job_name      = "${var.job_name}"
    region        = "${var.region}"
    datacenters   = "${join(",",var.datacenters)}"
    cpu_limit     = "${var.cpu_limit}"
    mem_limit     = "${var.mem_limit}"
    net_limit     = "${var.net_limit}"
    nomad_enable  = "${var.nomad_enable}"
    nomad_address = "${var.nomad_address}"
    node_class    = "${var.node_class}"
    listen_port = "${var.listen_port}"
  }
}

resource "nomad_job" "hashi-ui" {
  count   = "${var.run}"
  jobspec = "${data.template_file.hashi-ui.rendered}"
}
