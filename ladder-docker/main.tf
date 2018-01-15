data "template_file" "ladder-docker" {
  count    = "${var.run}"
  template = "${file("${path.module}/templates/ladder-docker.hcl")}"

  vars {
    job_name    = "${var.job_name}"
    region      = "${var.region}"
    image_tag   = "${var.image_tag}"
    datacenters = "${join(",",var.datacenters)}"
    cpu_limit   = "${var.cpu_limit}"
    mem_limit   = "${var.mem_limit}"
    net_limit   = "${var.net_limit}"
  }
}

resource "nomad_job" "ladder-docker" {
  jobspec = "${data.template_file.ladder-docker.rendered}"
}
