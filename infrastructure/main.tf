resource "helm_release" "ingress-nginx" {
  name = "ingress-nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart = "ingress-nginx"
  namespace = "ingress"
  version = "4.0.13"
  create_namespace = true
  timeout = 300

  values = [
    "${file("./chart_values.yaml")}"
  ]

  set {
    name  = "cluster.enabled"
    value = "true"
  }

  set {
    name  = "metrics.enabled"
    value = "true"
  }
  
}


resource "helm_release" "kube-prometheus" {
  name       = "kube-prometheus-stackr"
  namespace  = "prometheus"
  create_namespace = true
  repository = "https://prometheus-community.github.io/helm-charts"
  chart      = "kube-prometheus-stack"
}