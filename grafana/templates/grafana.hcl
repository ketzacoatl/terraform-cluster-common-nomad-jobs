job "${job_name}" {
  region      = "${region}"
  datacenters = ["${datacenters}"]
  type        = "service"

  group "ui" {
    count  = 1

    task "ui" {
      driver = "docker"
      config {
        image   = "grafana/grafana"
      }

      constraint {
        attribute = "$${node.class}"
        operator  = "="
        value     = "${node_class}"
      }

      resources {
        cpu    = ${cpu_limit}
        memory = ${mem_limit}
        network {
          mbits = ${net_limit}
          port "http" {
            static = 3000
          }
        }
      }

      service {
        port = "http"

        check {
          type     = "http"
          path     = "/"
          interval = "30s"
          timeout  = "5s"
        }
      }
    }
  }
}

