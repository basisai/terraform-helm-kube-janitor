locals {
  kube_janitor_enabled           = var.kube_janitor_enabled ? 1 : 0
  kube_janitor_namespace         = "core"
  kube_janitor_cluster_read_name = "${var.kube_janitor_service_account}-cluster-read"
}

resource "helm_release" "kube_janitor" {
  count = local.kube_janitor_enabled

  name       = var.kube_janitor_release_name
  chart      = var.kube_janitor_chart_name
  repository = var.kube_janitor_chart_repository_url
  version    = var.kube_janitor_chart_version
  namespace  = local.kube_janitor_namespace

  max_history = var.max_history

  values = [
    data.template_file.kube_janitor[0].rendered,
  ]
}

data "template_file" "kube_janitor" {
  count = local.kube_janitor_enabled

  template = file("${path.module}/templates/kube_janitor.yaml")

  vars = {
    image     = var.kube_janitor_image
    image_tag = var.kube_janitor_image_tag

    resources       = jsonencode(var.kube_janitor_resources)
    service_account = kubernetes_service_account.kube_janitor[0].metadata[0].name

    tolerations   = jsonencode(var.kube_janitor_tolerations)
    affinity      = jsonencode(var.kube_janitor_affinity)
    node_selector = jsonencode(var.kube_janitor_node_selector)

    schedule = var.kube_janitor_schedule
    rules    = jsonencode(var.kube_janitor_rules)
    dry_run  = jsonencode(var.kube_janitor_dry_run)
  }
}

resource "kubernetes_service_account" "kube_janitor" {
  count = local.kube_janitor_enabled

  metadata {
    name      = var.kube_janitor_service_account
    namespace = local.kube_janitor_namespace
    annotations = {
      terraform = "true"
    }
  }
}

resource "kubernetes_role" "kube_janitor" {
  count = var.kube_janitor_enabled ? length(var.kube_janitor_working_namespaces) : 0

  metadata {
    name      = var.kube_janitor_service_account
    namespace = var.kube_janitor_working_namespaces[count.index]
    annotations = {
      terraform = "true"
    }
  }

  rule {
    api_groups = [""]
    resources  = ["events"]
    verbs      = ["create"]
  }
  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["delete"]
  }
}

resource "kubernetes_cluster_role" "kube_janitor_read_everywhere" {
  count = local.kube_janitor_enabled

  metadata {
    name = local.kube_janitor_cluster_read_name
    annotations = {
      terraform = "true"
    }
  }

  rule {
    api_groups = ["*"]
    resources  = ["*"]
    verbs      = ["get", "watch", "list"]
  }
}

resource "kubernetes_role_binding" "kube_janitor" {
  count = var.kube_janitor_enabled ? length(var.kube_janitor_working_namespaces) : 0

  metadata {
    name      = var.kube_janitor_service_account
    namespace = var.kube_janitor_working_namespaces[count.index]
    annotations = {
      terraform = "true"
    }
  }
  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "Role"
    name      = kubernetes_role.kube_janitor[0].metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.kube_janitor[0].metadata[0].name
    namespace = kubernetes_service_account.kube_janitor[0].metadata[0].namespace
  }
}

resource "kubernetes_cluster_role_binding" "kube_janitor_read_everywhere" {
  count = local.kube_janitor_enabled

  metadata {
    name = local.kube_janitor_cluster_read_name
    annotations = {
      terraform = "true"
    }
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = kubernetes_cluster_role.kube_janitor_read_everywhere[0].metadata[0].name
  }

  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.kube_janitor[0].metadata[0].name
    namespace = kubernetes_service_account.kube_janitor[0].metadata[0].namespace
  }
}
