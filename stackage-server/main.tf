data "template_file" "stackage-server" {
  count    = "${var.run}"
  template = "${file("${path.module}/templates/stackage-server.hcl")}"

  vars {
    job_name    = "${var.job_name}"
    region      = "${var.region}"
    datacenters = "${join(",",var.datacenters)}"
    node_class  = "${var.node_class}"
    cpu_limit   = "${var.cpu_limit}"
    mem_limit   = "${var.mem_limit}"
    net_limit   = "${var.net_limit}"
    pg_conn     = "${var.pg_connection}"
    app_root    = "${var.app_root}"
  }
}

resource "nomad_job" "stackage-server" {
  jobspec = "${data.template_file.stackage-server.rendered}"
}
