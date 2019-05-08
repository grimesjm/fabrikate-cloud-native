# fabrikate-cloud-native

An opinionated open platform cloud native Fabrikate stack for operating Kubernetes clusters.

It includes:

### Cluster Maintainance (via [fabrikate-kured](https://github.com/timfpark/fabrikate-kured))
-   [Kured](https://github.com/weaveworks/kured): Automatic node reboot when OS is patched. 

### Metrics Monitoring (via [fabrikate-prometheus-grafana](https://github.com/timfpark/fabrikate-prometheus-grafana))
-   [Prometheus](https://prometheus.io/) Metrics aggregation
-   [Grafana](https://grafana.com/) Visualization with Kubernetes monitoring dashboards preconfigured

### Log Management (via [fabrikate-elasticsearch-fluentd-kibana](https://github.com/timfpark/fabrikate-elasticsearch-fluentd-kibana))
-   [Fluentd](https://www.fluentd.org/): Collection and forwarding
-   [Elasticsearch](https://www.elastic.co/): Aggregation and query execution
-   [Kibana](https://www.elastic.co/products/kibana): Full text query UI and visualization

### Service Mesh (via [fabrikate-istio](https://github.com/evanlouie/fabrikate-istio))
-   [Istio](https://istio.io/): Connect, secure, control, and observe services.
-   [CertManager](https://docs.cert-manager.io/en/latest/#): For retrieving SSL certs

### Distributed Tracing (via [fabrikate-jaeger](https://github.com/bnookala/fabrikate-jaeger))
-   [Jaeger](https://www.jaegertracing.io/): Distributed transaction, latency, and dependency tracing






## Running

```
mkdir -p fabrikated && cd fabrikated
fab add cloud-native --source https://github.com/grimesjm/fabrikate-cloud-native
fab install
fab generate prod aws
kubectl apply --recursive -f . 
```


### Untested
Set `NAME` and `INGRESS_DOMAIN` to give the certificate resource a name and a domain to control and run `certs/apply.sh`


### Notes

* Set `slack-hook-url` for Kured set this in config/prod.yaml and/or config/dev.yaml
* Set email for cert-manager - set in config/common.yaml



### Does not work yet, need a newer version of the Kured container 
If you have any one off pods such as Jobs or Cronjobs that are expensive in CPU or time, Add the following selectors to the pod:

```
"metadata": {
  "labels": {
    "runtime" : "long",
    "cost" : "expensive"
  }
}
```

This will prevent us from rebooting a recently patched node while the pod is running. 


### TODO

* Run kube-bench
* Set pod security policies
* Verify PV/PVC's
* Feed prometheus alert-manager slack config
