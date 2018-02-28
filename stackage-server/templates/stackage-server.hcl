job "${job_name}" {
  region      = "${region}"
  datacenters = ["${datacenters}"]
  type        = "service"

  group "stackage-server" {

    task "server" {
      count  = 2
      driver = "docker"

      config {
        image    = "fpco/stackage-server-prod:latest"
        command  = "stackage-server"
        work_dir = "/app"

        port_map {
          http = 3000
        }
      }

      env {
        APPROOT  = "${app_root}"
        PGSTRING = "${pg_conn}"
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
          port "http" {}
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

    task "hoogle" {
      count  = 2
      driver = "docker"

      config {
        image    = "fpco/stackage-server-prod:latest"
        command  = "stackage-server"
        work_dir = "/app"

        port_map {
          http = 3000
        }
      }

      env {
        APPROOT  = "${app_root}"
        PGSTRING = "${pg_conn}"
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
          port "http" {}
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

