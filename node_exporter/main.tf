data "template_file" "node_exporter" {
  count    = "${var.run}"
  template = "${file("${path.module}/templates/node_exporter.hcl")}"

  vars {
    job_name    = "${var.job_name}"
    region      = "${var.region}"
    datacenters = "${join(",",var.datacenters)}"
    version     = "${var.version}"
    checksum    = "${var.checksum}"
    cpu_limit   = "${var.cpu_limit}"
    mem_limit   = "${var.mem_limit}"
    net_limit   = "${var.net_limit}"
  }
}

resource "nomad_job" "node_exporter" {
  jobspec = "${data.template_file.node_exporter.rendered}"
}
