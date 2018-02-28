job "${job_name}" {
  region      = "${region}"
  datacenters = ["${datacenters}"]
  type        = "system"

  group "cadvisor" {

    task "cadvisor" {
      driver = "docker"

      config {
        image   = "google/cadvisor"

        args = ["--port=9111"]

        port_map {
          http = 9111
        }

        volumes = [
          "/:/rootfs:ro",
          "/var/run:/var/run:rw",
          "/sys:/sys:ro",
          "/var/lib/docker/:/var/lib/docker:ro",
          "/dev/disk/:/dev/disk:ro",
        ]
      }

      service {
        name = "cadvisor"
        port = "metrics"
        tags = [ "scrape-metrics" ]

        check {
          type     = "http"
          path     = "/"
          interval = "30s"
          timeout  = "5s"
        }
      }

      resources {
        cpu    = ${cpu_limit}
        memory = ${mem_limit}
        network {
          mbits = ${net_limit}

          port "metrics" {
            static = 9111
          }
        }
      }
    }
  }
}
