data "template_file" "hashi-ui" {
  count    = "${var.run}"
  template = "${file("${path.module}/templates/hashi-ui.hcl")}"

  vars {
    job_name      = "${var.job_name}"
    region        = "${var.region}"
    datacenters   = "${join(",",var.datacenters)}"
    cpu_limit     = "${var.cpu_limit}"
    mem_limit     = "${var.mem_limit}"
    net_limit     = "${var.net_limit}"
    nomad_enable  = "${var.nomad_enable}"
    nomad_address = "${var.nomad_address}"
  }
}

resource "nomad_job" "hashi-ui" {
  jobspec = "${data.template_file.hashi-ui.rendered}"
}
