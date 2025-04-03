# Mastodon

Opinioned [Helm](https://helm.sh/) chart to deploy Mastodon to a Kubernetes cluster.

Based on [upstream Helm chart](https://github.com/mastodon/mastodon/tree/628b3fa44916dba1bcb24af0a92b49edc4bf49ce/chart), drastically simplified and extended to support `DATABASE_URL`.


### Usage

Copy `values.example.yaml` into `values.yaml` and customize.

```bash
# update helm dependencies
helm dep update

# install chart
helm install mastodon ./ -f values.yaml --namespace mastodon --create-namespace

# upgrade chart
helm upgrade mastodon ./ -f values.yaml --namespace mastodon
```


### tootctl

You can run [admin CLI](https://docs.joinmastodon.org/admin/tootctl/) commands in the web deployment.

```bash
# spawn a bash session
kubectl -n mastodon exec -it deployment/mastodon-web -- bash
tootctl accounts modify admin --reset-password

# or exec tootctl directly
kubectl -n mastodon exec -it deployment/mastodon-web -- tootctl accounts modify admin --reset-password
```


### Minimum Cost Deployment

Ideal for a tiny Mastodon instance that typically serves less than 5 users.

##### Compute

[Oracle Cloud](https://www.oracle.com/ca-en/cloud/free/#always-free) Always Free tier offers ample computing power, together with [Oracle Kubernetes Engine](https://www.oracle.com/ca-en/cloud/cloud-native/container-engine-kubernetes/), you can get a powerful 4C24G (ARM Yes!) cluster in no time.

##### Postgres Hosting

- [Aiven for PostgreSQL](https://aiven.io/pricing?product=pg) free plan offers 5GiB of storage and 20 concurrent connections
- [Tembo](https://tembo.io/pricing/) free plan offers 10GiB of storage
- [Xata](https://xata.io/pricing) free plan offers 15GiB of storage

##### Redis Hosting

- [Aiven for Valkey](https://aiven.io/pricing?product=valkey) free plan offers 1GiB of RAM

##### Image Hosting

Lots of S3-compatible storage providers offer free storage quota, but few like [Cloudflare R2](https://developers.cloudflare.com/r2/platform/pricing/) offers free traffic.
