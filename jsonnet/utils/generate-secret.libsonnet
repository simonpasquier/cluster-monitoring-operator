{
  staticAuthSecret(cfgNamespace, cfgCommonLabels, cfgName):: {
    apiVersion: 'v1',
    kind: 'Secret',
    metadata: {
      name: cfgName,
      namespace: cfgNamespace,
      labels: cfgCommonLabels,
    },
    type: 'Opaque',
    data: {},
    stringData: {
      'config.yaml': std.manifestYamlDoc({
        authorization: {
          static: [
            {
              user: {
                name: 'system:serviceaccount:openshift-monitoring:prometheus-k8s',
              },
              verb: 'get',
              path: '/metrics',
              resourceRequest: false,
            },
            {
              user: {
                name: 'system:serviceaccount:openshift-monitoring:prometheus-k8s-federate',
              },
              verb: 'get',
              path: '/federate',
              resourceRequest: false,
            },
          ],
        },
      },),
    },
  },
}
