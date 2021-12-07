# Testing Rancher Custom Downstream Cluster in Hetzner Cloud

## Using

`terraform.tfvars`

```terraform
hcloud_token        = "xxx"
rancher_agent_token = "xxx"
cluster_name        = "test-custom"
rancher_url         = "https://rancher.example.com"
cluster_cp_count    = 3
cluster_worker_count    = 3
```

## Documentation

* [Install/Upgrade Rancher on a Linux OS](https://rancher.com/docs/rancher/v2.x/en/installation/install-rancher-on-linux/)
* [RancherD Configuration Reference](https://rancher.com/docs/rancher/v2.x/en/installation/install-rancher-on-linux/rancherd-configuration/)
