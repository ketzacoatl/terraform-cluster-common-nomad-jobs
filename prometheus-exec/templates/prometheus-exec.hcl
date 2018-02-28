job "prometheus" {
  region      = "${region}"
  datacenters = ["${datacenters}"]
  type        = "service"

  group "prom" {
    count  = 1

    task "server" {
      driver = "exec"

      artifact {
        source      = "https://github.com/prometheus/prometheus/releases/download/v${version}/prometheus-${version}.linux-amd64.tar.gz"
        destination = "local/"

        options {
          checksum = "${checksum}"
        }
      }

      config {
        command = "prometheus-${version}.linux-amd64/prometheus"

        args = [
          "-config.file=local/config.yaml"
        ]
      }

      constraint {
        attribute = "$${node.class}"
        operator  = "="
        value     = "${node_class}"
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

      resources {
        cpu    = ${cpu_limit}
        memory = ${mem_limit}
        network {
          mbits = ${net_limit}

          port "http" {
            static = 9090
          }
        }
      }

      template {
        data = <<EOH
global:
  scrape_interval: 30s
  scrape_timeout: 30s

scrape_configs:
  # one for the server itself
  - job_name: 'prometheus'
    # Override the global default and scrape targets from this job every 5 seconds.
    #scrape_interval: 5s
    # metrics_path defaults to '/metrics'
    # scheme defaults to 'http'.
    static_configs:
      - targets: ['localhost:9090']

  # this scrapes using consul for service discovery
  - job_name: 'consul-sd'
    consul_sd_configs:
      - server: ${consul_server}
        token: ${consul_token}
    relabel_configs:
      - source_labels: ['__meta_consul_tags']
        regex: .*,scrape-metrics,.*
        action: keep
    # - source_labels: [__meta_consul_node]
    #   target_label: instance
    # - source_labels: [__meta_consul_service]
    #   target_label: job
EOH

        destination = "local/config.yaml"
      }
    }
  }
}
