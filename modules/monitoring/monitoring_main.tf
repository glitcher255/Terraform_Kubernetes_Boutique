resource "helm_release" "tempo" {
  name       = "tempo"
  namespace  = var.monitoring_namespace
  repository = "https://grafana.github.io/helm-charts"
  chart      = "tempo"
  #version    = "1.7.1"  # Pin versions for stability
  values     = [file("${path.module}/../../k8s/tempo/values.yaml")]
}

resource "helm_release" "prometheus_stack" {
  name       = "monitoring"
  namespace  = var.monitoring_namespace
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
  values     = [file("${path.module}/../../k8s/grafana/values.yaml")]
}

resource "helm_release" "loki" {
  name       = "loki"
  namespace  = var.monitoring_namespace
  repository = "https://grafana.github.io/helm-charts"
  chart      = "loki"
  values     = [file("${path.module}/../../k8s/loki/values.yaml")]
}

resource "helm_release" "alloy" {
  name       = "alloy"
  namespace  = var.monitoring_namespace
  repository = "https://grafana.github.io/helm-charts"
  chart      = "alloy"
  values     = [file("${path.module}/../../k8s/alloy/values.yaml")]
}

resource "helm_release" "otel_collector" {
  name       = "otel-collector"
  namespace  = var.monitoring_namespace
  repository = "https://open-telemetry.github.io/opentelemetry-helm-charts"
  chart      = "opentelemetry-collector"
  values     = [file("${path.module}/../../k8s/otel/values.yaml")]
}

resource "helm_release" "boutique" {
  name       = "boutique"
  namespace  = var.monitoring_namespace
  chart      = "${path.module}/../../boutique"
}