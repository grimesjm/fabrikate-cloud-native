#!/bin/bash

cat <<EOF | kubectl apply -f -
apiVersion: certmanager.k8s.io/v1alpha1
kind: Certificate
metadata:
  name: ingress-cert-$NAME
  namespace: istio-system
spec:
  secretName: ingress-cert-$NAME
  issuerRef:
    name: letsencrypt
    kind: ClusterIssuer
  commonName: $INGRESS_DOMAIN
  dnsNames:
  - $INGRESS_DOMAIN
  acme:
    config:
    - http01:
        ingressClass: istio
      domains:
      - $INGRESS_DOMAIN
---
EOF