locals {
  name = "sysdig-agent"

  default_helm_config = {
    name             = "sysdig-agent"
    namespace        = "sysdig-agent"
    chart            = "sysdig-deploy"
    repository       = "https://charts.sysdig.com"
    version          = "1.3.12"
    namespace        = local.name
    create_namespace = true
    values           = local.default_helm_values
    set              = []
    description      = "Sysdig HelmChart Sysdig-Deploy configuration"
    wait             = false
  }

  default_helm_values = [templatefile("${path.module}/sysdig_helm_values.yml", 
    {
      sysdig-accesskey                  = ""
      sysdig-collector-endpoint         = ""
      sysdig-nodeanalyzer-api-endpoint  = ""
    },
  )]

  helm_config = merge(
    local.default_helm_config,
    var.helm_config
  )

  argocd_gitops_config = {
    enable = true
  }
}