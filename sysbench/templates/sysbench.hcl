job "${job_name}" {
  region      = "${region}"
  datacenters = ["${datacenters}"]
  type        = "batch"

  group "sysbench" {
    count  = 2

    task "sysbench" {
      driver = "docker"
      config {
        image   = "tjakobsson/sysbench:${image_tag}"
        command = "sysbench"
        args    = ["--test=cpu", "--cpu-max-prime=20000000", "run"]
      }

      resources {
        cpu    = ${cpu_limit}
        memory = ${mem_limit}
        network {
          mbits = ${net_limit}
        }
      }
    }
  }
}
