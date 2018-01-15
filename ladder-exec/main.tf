data "template_file" "ladder-exec" {
  count    = "${var.run}"
  template = "${file("${path.module}/templates/ladder-exec.hcl")}"

  vars {
    job_name    = "${var.job_name}"
    region      = "${var.region}"
    version     = "${var.version}"
    checksum    = "${var.checksum}"
    datacenters = "${join(",",var.datacenters)}"
    node_class  = "${var.node_class}"
    cpu_limit   = "${var.cpu_limit}"
    mem_limit   = "${var.mem_limit}"
    net_limit   = "${var.net_limit}"
  }
}

resource "nomad_job" "ladder-exec" {
  jobspec = "${data.template_file.ladder-exec.rendered}"
}
