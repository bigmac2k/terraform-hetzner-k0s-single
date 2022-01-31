provider "helm" {
  kubernetes {
    host     = "https://${hcloud_server.server.ipv4_address}:6443"
    client_certificate     = base64decode(module.k0sctl.client_certificate)
    client_key             = base64decode(module.k0sctl.client_key)
    cluster_ca_certificate = base64decode(module.k0sctl.cluster_ca_certificate)
  }
}
provider "kubernetes" {
  host     = "https://${hcloud_server.server.ipv4_address}:6443"
  client_certificate     = base64decode(module.k0sctl.client_certificate)
  client_key             = base64decode(module.k0sctl.client_key)
  cluster_ca_certificate = base64decode(module.k0sctl.cluster_ca_certificate)
}

resource "helm_release" "hcloud-csi" {
  name = "hcloud-csi"
  namespace = "kube-system"
  repository = "./charts"
  chart = "hcloud-csi"
  create_namespace = true
  dependency_update = true

  set {
    name = "hcloud_token"
    value = var.hcloud_token
  }
  set {
    name = "kubelet_dir"
    value = "/var/lib/k0s/kubelet"
  }
}

resource "helm_release" "traefik" {
  name = "traefik"
  namespace = "traefik"
  repository = "https://helm.traefik.io/traefik"
  chart = "traefik"
  create_namespace = true
  dependency_update = true
  values = [
  <<-EOF
    deployment:
      kind: DaemonSet
    service:
      type: NodePort
      externalIPs:
        - ${hcloud_server.server.ipv4_address}
    EOF
  ]
}

resource "helm_release" "cert-manager" {
  name = "cert-manager"
  namespace = "cert-manager"
  repository = "https://charts.jetstack.io"
  chart = "cert-manager"
  create_namespace = true
  dependency_update = true
  set {
    name = "installCRDs"
    value = true
  }
}

resource "helm_release" "letsencrypt_issuer" {
  name = "letsencrypt-issuer"
  namespace = "cert-manager"
  repository = "./charts"
  chart = "letsencrypt-issuer"
  create_namespace = true
  dependency_update = true

  values = [
    <<-EOF
    email: "sven@sven.cc"
    privateKeyRef: "issuer-account-key-staging"
    solvers: |
      - http01:
          ingress:
            serviceType: ClusterIP
            ingressTemplate:
              metadata:
                annotations:
                  traefik.ingress.kubernetes.io/router.entrypoints: "web"
    EOF
  ]

  depends_on = [helm_release.cert-manager]
}

resource "helm_release" "openebs" {
  name = "openebs"
  namespace = "openebs"
  repository = "https://openebs.github.io/charts"
  chart = "openebs"
  create_namespace = true
  dependency_update = true
}
