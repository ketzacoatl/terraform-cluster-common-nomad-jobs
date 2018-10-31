job "statsd-metrics" {
  region      = "${region}"
  datacenters = ["${datacenters}"]
  type        = "service"

  group "statsd-exporter" {
    count  = 1

    task "statsd-exporter" {
      driver = "docker"
      config {
        image   = "prom/statsd-exporter"
        # args    = ["-statsd.mapping-config", "${statsd_mapping_config}"]
        #dns_servers = ["172.17.0.1"]
        network_mode = "host"
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
            static = 9125
          }
          port "http" {
            static = 9102
          }
        }
      }

      service {
        name = "statsd-exporter"
        port = "http"
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
