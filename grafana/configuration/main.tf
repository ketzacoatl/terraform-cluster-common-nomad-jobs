provider "grafana" {
  url = "${var.url}"
  auth = "${var.auth}"
}

resource "grafana_organization" "org" {
  count        = "${length(var.orgs)}"
  create_users = true
  name = "${lookup(element(var.orgs, count.index), "name")}"
  admin_user = "${element(split(var.auth, ":"), 1)}"
  admins = "${element(var.orgs_admins, count.index)}"
  editors = "${element(var.orgs_editors, count.index)}"
  viewers = "${element(var.orgs, count.index)}"
  # admin_user = "${element(var.orgs, count.index)["admin_user"]}"
  # admins = "${element(var.orgs, count.index)["admins"]}"
  # editors = "${element(var.orgs, count.index)["editors"]}"
  # viewers = "${element(var.orgs, count.index)["viewers"]}"
}

# resource "grafana_data_source" "prometheus-x" {
#   type = "${var.data_source_type}"
#   name = "${var.data_source_name}"
#   url = "${var.data_source_url}"
#   is_default = "${var.data_source_is_default}"
# }

# resource "grafana_dashboard" "node-exporter-stats" {
#   # There are caveats regarding dashboard templating in Grafana
#   # Please refer to the following to understand the issue
#   # https://github.com/utkarshcmu/wizzy/issues/107
#   # https://github.com/grafana/grafana/issues/10786
#   config_json = "${file("node-exporter-dashboard.json")}"
#   depends_on = ["grafana_data_source.prometheus-x"]
# }

# resource "grafana_alert_notification" "email_someteam" {
#   name = "Email that team"
#   type = "email"
#   is_default = false

#   settings {
#     "addresses" = "foo@example.net;bar@example.net"
#     "uploadImage" = "false"
#   }
# }
