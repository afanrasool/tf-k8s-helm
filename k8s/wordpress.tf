resource "helm_release" "wordpress" {
  name       = "wordpress"
  chart      = "stable/wordpress"

  set {
    name  = "mariadb.enabled"
    value = "false"
  }

  set {
    name  = "mariadb.enabled"
    value = "false"
  }

  set {
    name  = "externalDatabase.host"
    value = "${var.sql_private_ip}"
  }

  set {
    name  = "externalDatabase.user"
    value = "default"
  }

  set {
    name  = "externalDatabase.password"
    value = "${var.generated_user_password}"
  }

  set {
    name  = "externalDatabase.database"
    value = "default"
  }
}

#Storing external ip information
data "kubernetes_service" "wordpress" {
  metadata {
        name = "wordpress-wordpress"
  }
  depends_on = [helm_release.wordpress]
}
