variable "org" {
  description = "Organization map with fields: name, admin_user, admins, editors, viewers"
  default = {}
}

resource "grafana_organization" "org" {
  name         = "${var.org["name"]}"
  admin_user   = "${var.org["admin_user"]}"
  create_users = true
  admins       = ["${var.org["admins"]}"]
  editors      = ["${var.org["editors"]}"]
  viewers      = ["${var.org["viewers"]}"]
}
