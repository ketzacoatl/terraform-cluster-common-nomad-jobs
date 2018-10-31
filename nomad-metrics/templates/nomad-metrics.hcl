job "nomad-metrics" {
  region      = "${region}"
  datacenters = ["${datacenters}"]
  type        = "service"

  group "nomad-exporter" {
    count  = 1

    task "nomad-exporter" {
      driver = "docker"
      config {
        image   = "nomon/nomad-exporter"
        args    = ["nomad.server", "${nomad_address}"]
        command = "nomad-exporter"
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
          port "metrics" {
            static = 9172
          }
        }
      }

      service {
        name = "nomad-exporter"
        port = "metrics"
        tags = [ "scrape-metrics" ]

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
