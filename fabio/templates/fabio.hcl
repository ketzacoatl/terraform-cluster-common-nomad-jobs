job "${job_name}" {
  region      = "${region}"
  datacenters = ["${datacenters}"]
  type        = "service"

  group "fabio" {
    count  = 1

    task "server" {
      driver = "exec"

      artifact {
        source      = "https://github.com/fabiolb/fabio/releases/download/v1.5.3/fabio-${version}-linux_amd64"
        destination = "local/"

        options {
          checksum = "${checksum}"
        }
      }

      config {
        command = "local/fabio-${version}-linux_amd64"

        args = [
          # Consul address for testing into a vagrant box
          "-registry.consul.addr", "10.0.2.15:8500"
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
            static = 9999
          }
        }
      }

      template {
        data = <<EOH
# registry.consul.addr = localhost:8500
        EOH

        destination = "local/fabio.properties"
      }
    }
  }
}
