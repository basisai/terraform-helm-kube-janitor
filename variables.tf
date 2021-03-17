variable "kube_janitor_enabled" {
  description = "Enable/disable cleaning up of old resources"
  default     = false
}

variable "kube_janitor_release_name" {
  description = "Release name for Kube Janitor"
  default     = "kube-janitor"
}

variable "kube_janitor_chart_name" {
  description = "Chart name for Kube Janitor"
  default     = "kube-janitor"
}

variable "kube_janitor_chart_repository_url" {
  description = "Chart repository URL for Kube Janitor"
  default     = "https://basisai.github.io/kube-janitor-helm"
}

variable "kube_janitor_chart_version" {
  description = "Chart version for Kube Janitor"
  default     = "1.0.4"
}

variable "kube_janitor_image" {
  description = "Docker image for Kube Janitor"
  default     = "hjacobs/kube-janitor"
}

variable "kube_janitor_image_tag" {
  description = "Docker image tag for Kube Janitor"
  default     = "20.4.1"
}

variable "kube_janitor_schedule" {
  description = "Run frequency as a cron expression. Default hourly"
  default     = "0 * * * *"
}

variable "kube_janitor_rules" {
  description = "Cleaning rules"
  type        = map(any)
}

variable "kube_janitor_resources" {
  description = "Resources for Kube Janitor"

  default = {
    requests = {
      cpu    = "20m"
      memory = "100Mi"
    }
    limits = {
      cpu    = "100m"
      memory = "100Mi"
    }
  }
}

variable "kube_janitor_service_account" {
  description = "Service account for Kube Janitor"
  default     = "kube-janitor"
}

variable "kube_janitor_node_selector" {
  description = "Node labels for pod assignment for Kube Janitor"
  default     = {}
}

variable "kube_janitor_affinity" {
  description = "Affinity settings for Kube Janitor"
  default     = {}
}

variable "kube_janitor_tolerations" {
  description = "List of map of tolerations for Kube Janitor"
  default     = []
}


variable "kube_janitor_working_namespaces" {
  description = "Namespaces where Kube Janitor will clean resources"
}

variable "kube_janitor_dry_run" {
  description = "Run Kube Janitor in dry-run mode"
  default     = false
}

variable "max_history" {
  description = "Max History for Helm"
  default     = 20
}
