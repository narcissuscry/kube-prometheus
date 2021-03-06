local service(name, namespace, labels, selector, ports) = {
  apiVersion: 'v1',
  kind: 'Service',
  metadata: {
    name: name,
    namespace: namespace,
    labels: labels,
  },
  spec: {
    ports+: ports,
    selector: selector,
    clusterIP: 'None',
  },
};

{
  prometheus+:: {
    kubeControllerManagerPrometheusDiscoveryService: service(
      'kube-controller-manager-prometheus-discovery',
      'kube-system',
      { 'k8s-app': 'kube-controller-manager' },
      { 'k8s-app': 'kube-controller-manager' },
      [{ name: 'https-metrics', port: 10257, targetPort: 10257 }]
    ),

    kubeSchedulerPrometheusDiscoveryService: service(
      'kube-scheduler-prometheus-discovery',
      'kube-system',
      { 'k8s-app': 'kube-scheduler' },
      { 'k8s-app': 'kube-scheduler' },
      [{ name: 'https-metrics', port: 10259, targetPort: 10259 }]
    ),

    kubeDnsPrometheusDiscoveryService: service(
      'kube-dns-prometheus-discovery',
      'kube-syste',
      { 'k8s-app': 'kube-dns' },
      { 'k8s-app': 'kube-dns' },
      [{ name: 'http-metrics-skydns', port: 10055, targetPort: 10055 }, { name: 'http-metrics-dnsmasq', port: 10054, targetPort: 10054 }]
    ),
  },
}
