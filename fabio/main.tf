data "template_file" "fabio" {
  count    = "${var.run}"
  template = "${file("${path.module}/templates/fabio.hcl")}"

  vars {
    job_name    = "${var.job_name}"
    region      = "${var.region}"
    datacenters = "${join(",",var.datacenters)}"
    version     = "${var.version}"
    checksum    = "${var.checksum}"
    node_class  = "${var.node_class}"
    cpu_limit   = "${var.cpu_limit}"
    mem_limit   = "${var.mem_limit}"
    net_limit   = "${var.net_limit}"
  }
}

resource "nomad_job" "fabio" {
  jobspec = "${data.template_file.fabio.rendered}"
}
