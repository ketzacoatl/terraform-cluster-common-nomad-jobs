job "${job_name}" {
  region      = "${region}"
  datacenters = ["${datacenters}"]
  type        = "service"

  group "ladder" {
    count  = 1

    task "ladder" {
      driver = "docker"
      config {
        image   = "themotion/ladder:${image_tag}"
        command = "/bin/ladder"

        network_mode = "host"

        volumes = [
          "local/ladder.yml:/etc/ladder/ladder.yml",
          "local/autoscaler.yml:/etc/ladder/autoscaler.yml"
        ]

        work_dir = "/etc/ladder"
      }

      env {
        AWS_SECRET_ACCESS_KEY = ""
        AWS_ACCESS_KEY_ID     = ""
      }
      service {
        port = "metrics"

        check {
          type     = "http"
          path     = "/check"
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
            static = 9094
          }
        }
      }

      template {
        data = <<EOH
        global:
          warmup: 30s
        
        autoscaler_files:
          - "/etc/ladder/autoscaler.yml"
        EOH

        destination = "local/ladder.yml"
      }

      template {
        data = <<EOH
        autoscalers:
        - name: asg_autoscaler
          description: >
            set "desired node count" on an AWS autoscaling group based on the overall load
            on the cluster (as seen by cloud watch)
          interval: 2m
          scaling_wait_timeout: 4m
        
          scale:
            kind: aws_autoscaling_group
            config:
              auto_scaling_group_name: "data-ops-eval-workers-us-west-2"
              aws_region: "us-west-2"
              scale_up_wait_duration: 1m
              scale_down_wait_duration: 15s
        
          filters:
            - kind: scaling_kind_interval
              config:
                scale_up_duration: 2m
                scale_down_duration: 10m
        
            - kind: limit
              config:
                max: 10
                min: 2
        
          inputters:
          - name: cluster_cpu_load
            description: "Get % cpu utilization over recent period and scale up/down"
            gather:
              kind: aws_cloudwatch_metric
              config:
                metric_name: "CPUUtilization"
                namespace: "EC2"
                statistic: "Average"
                unit: "Percent"
                offset: "0s"
                dimensions:
                  - name: "ClusterName"
                    value: "data-ops-eval-workers-us-west-2"
                aws_region: "us-west-2"
            arrange:
              kind: threshold
              config:
                scaleup_percent: 10
                scaleup_threshold: 80
                scaleup_max_quantity: 2
                scaleup_min_quantity: 1
                scaledown_percent: 10
                scaledown_threshold: 40
                scaledown_max_quantity: 1
                scaledown_min_quantity: 1
        EOH

        destination = "local/autoscaler.yml"
      }
    }
  }
}
