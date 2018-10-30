job "hashi-ui" {
  region      = "${region}"
  datacenters = ["${datacenters}"]
  type        = "service"

  group "server" {
    count = 1

    task "hashi-ui" {
      driver = "rkt"

      config {
        image        = "jippi/hashi-ui"
        port_map {
          http = "${listen_port}-tcp"
        }
      }

      service {
        port = "http"

        check {
          type     = "http"
          path     = "/"
          interval = "10s"
          timeout  = "2s"
        }
      }

      env {
        NOMAD_ENABLE = ${nomad_enable}
        NOMAD_ADDR   = "${nomad_address}"
        LISTEN_ADDRESS = "0.0.0.0:${listen_port}"
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
            static = "${listen_port}"
          }
        }
      }
    }
  }
}
