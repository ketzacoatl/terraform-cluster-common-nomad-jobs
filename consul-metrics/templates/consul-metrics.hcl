job "consul-metrics" {
  region      = "${region}"
  datacenters = ["${datacenters}"]
  type        = "service"

  group "consul-exporter" {
    count  = 1

    task "consul-exporter" {
      driver = "docker"
      config {
        image   = "prom/consul-exporter"
        args    = ["--consul.server", "${consul_server}"]
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
            static = 9107
          }
        }
      }

      service {
        name = "consul-exporter"
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
