# Federid Helm Chart

This Helm chart deploys FederID components, including a webhook and SPIFFE helper, into a Kubernetes cluster. It provides configuration options for scaling, service definitions, security contexts, and more.

## Prerequisites

- Kubernetes 1.19+
- Helm 3.0+
- A namespace with the required permissions if using custom namespaces.

## Installation

To install the chart with the release name `federid`:

```bash
helm upgrade --install federid ./ --namespace federid --create-namespace
```

### Notes:
- The `--namespace` flag specifies the namespace to install FederID.
- Use `--create-namespace` if the namespace doesn't already exist.

## Configuration

You can customize the chart by overriding default values in a `values.yaml` file. Below are key configuration options. For the full list, see the default `values.yaml`.

### Global Settings

| Parameter         | Description                                  | Default               |
|-------------------|----------------------------------------------|-----------------------|
| `namespace`       | Namespace for the deployment                | `federid`            |
| `replicaCount`    | Number of replicas for the deployment       | `1`                   |
| `image.repository`| Container image repository                  | `federid/webhook`    |
| `image.pullPolicy`| Image pull policy                           | `Always`             |
| `image.tag`       | Tag of the container image                  | `latest`             |
| `imagePullSecrets`| Secrets for pulling images from registries   | `[]`                 |

### Service Account Configuration

| Parameter             | Description                                  | Default               |
|-----------------------|----------------------------------------------|-----------------------|
| `serviceAccount.create` | Whether to create a service account         | `true`               |
| `serviceAccount.automount` | If true, the ServiceAccount's API credentials will be mounted into pods | `true` |
| `serviceAccount.annotations` | Annotations for the service account       | `{}`                 |
| `serviceAccount.name`   | Name of the service account                 | `federid-webhook-admin` |

### SPIFFE Helper Configuration

| Parameter                         | Description                                  | Default               |
|-----------------------------------|----------------------------------------------|-----------------------|
| `configuration.SPIFFE_HELPER_SIDECAR_IMAGE`  | Image for the SPIFFE helper sidecar container | `federid/spiffe-helper:latest` |

### Resources Configuration

| Parameter             | Description                                  | Default               |
|-----------------------|----------------------------------------------|-----------------------|
| `resources.limits.cpu` | Maximum CPU resources                        | `100m`                |
| `resources.limits.memory` | Maximum memory resources                   | `30Mi`                |
| `resources.requests.cpu` | Minimum CPU resources                       | `100m`                |
| `resources.requests.memory` | Minimum memory resources                  | `20Mi`                |

### Autoscaling Configuration

| Parameter                         | Description                                  | Default               |
|-----------------------------------|----------------------------------------------|-----------------------|
| `autoscaling.enabled`            | Enable Horizontal Pod Autoscaler             | `false`               |
| `autoscaling.minReplicas`        | Minimum number of replicas                   | `1`                   |
| `autoscaling.maxReplicas`        | Maximum number of replicas                   | `100`                 |
| `autoscaling.targetCPUUtilizationPercentage` | Target CPU utilization percentage for autoscaling | `80`               |

### Affinity, Tolerations, and NodeSelector

| Parameter             | Description                                  | Default               |
|-----------------------|----------------------------------------------|-----------------------|
| `nodeSelector`        | Specify nodes the app can run on             | `{}`                  |
| `tolerations`         | Define tolerations for scheduling            | `[]`                  |
| `affinity`            | Define affinity settings for pod scheduling  | `{}`                  |

### Pod Disruption Budget

| Parameter             | Description                                  | Default               |
|-----------------------|----------------------------------------------|-----------------------|
| `podDisruptionBudget.minAvailable` | Minimum number of available pods during disruptions | `1`            |


## Testing the Chart

You can test the chart by running the following command:

```bash
helm test federid --namespace federid
```

This will execute any tests defined in the `templates/tests` directory (such as connectivity tests).

## Uninstallation

To uninstall the FederID release:

```bash
helm uninstall federid --namespace federid
```

This will delete the release from the cluster.

# Licensing

This project is licensed under the Apache License, Version 2.0.


