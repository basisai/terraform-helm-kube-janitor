# Kube Janitor

## Providers

| Name | Version |
|------|---------|
| helm | >= 1.0 |
| kubernetes | n/a |
| template | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| kube\_janitor\_affinity | Affinity settings for Kube Janitor | `map` | `{}` | no |
| kube\_janitor\_chart\_name | Chart name for Kube Janitor | `string` | `"kube-janitor"` | no |
| kube\_janitor\_chart\_repository | Chart repository for Kube Janitor | `string` | `"amoy"` | no |
| kube\_janitor\_chart\_version | Chart version for Kube Janitor | `string` | `"1.0.0"` | no |
| kube\_janitor\_dry\_run | Run Kube Janitor in dry-run mode | `bool` | `false` | no |
| kube\_janitor\_enabled | Enable/disable cleaning up of old resources | `bool` | `false` | no |
| kube\_janitor\_image | Docker image for Kube Janitor | `string` | `"hjacobs/kube-janitor"` | no |
| kube\_janitor\_image\_tag | Docker image tag for Kube Janitor | `string` | `"19.12.0"` | no |
| kube\_janitor\_node\_selector | Node labels for pod assignment for Kube Janitor | `map` | `{}` | no |
| kube\_janitor\_release\_name | Release name for Kube Janitor | `string` | `"kube-janitor"` | no |
| kube\_janitor\_resources | Resources for Kube Janitor | `map` | <pre>{<br>  "limits": {<br>    "cpu": "100m",<br>    "memory": "100Mi"<br>  },<br>  "requests": {<br>    "cpu": "20m",<br>    "memory": "100Mi"<br>  }<br>}</pre> | no |
| kube\_janitor\_rules | Cleaning rules | `map(any)` | n/a | yes |
| kube\_janitor\_schedule | Run frequency as a cron expression. Default hourly | `string` | `"0 * * * *"` | no |
| kube\_janitor\_service\_account | Service account for Kube Janitor | `string` | `"kube-janitor"` | no |
| kube\_janitor\_tolerations | List of map of tolerations for Kube Janitor | `list` | `[]` | no |
| kube\_janitor\_working\_namespaces | Namespaces where Kube Janitor will clean resources | `any` | n/a | yes |
| max\_history | Max History for Helm | `number` | `20` | no |

## Outputs

No output.
