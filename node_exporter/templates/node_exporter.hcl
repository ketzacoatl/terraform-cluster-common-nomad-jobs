job "${job_name}" {
  region      = "${region}"
  datacenters = ["${datacenters}"]
  type        = "system"

  group "node_exporter" {

    task "node_exporter" {
      driver = "raw_exec"

      artifact {
        source      = "https://github.com/prometheus/node_exporter/releases/download/v${version}/node_exporter-${version}.linux-amd64.tar.gz"
        destination = "local/"

        options {
          checksum = "${checksum}"
        }
      }

      config {
        command = "node_exporter-${version}.linux-amd64/node_exporter"
        args    = []
      }

      service {
        name = "node-exporter"
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
            static = 9100
          }
        }
      }
    }
  }
}
