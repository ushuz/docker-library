# Mastodon

Opinioned [Helm](https://helm.sh/) chart to deploy Mastodon to a Kubernetes cluster.

Based on [upstream Helm chart](https://github.com/mastodon/mastodon/tree/628b3fa44916dba1bcb24af0a92b49edc4bf49ce/chart), drastically simplified and extended to support `DATABASE_URL`.


### Usage

Copy `values.example.yaml` into `values.yaml` and customize.

```bash
# update helm dependencies
helm dep update

# install chart
helm install mastodon ./ -f path/to/values.yaml --namespace mastodon --create-namespace

# upgrade chart
helm upgrade --namespace mastodon mastodon ./ -f path/to/values.yaml
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

##### Hosted Database

- [Supabase](https://supabase.com/pricing) Free plan offers fully functional PostgreSQL databases with up to 500MB storage
- [Neon](https://neon.tech/docs/introduction/technical-preview-free-tier/) Technical Preview offers serverless PostgreSQL databases with up to 10GB storage, paid tiers are expected to launch in Q1 2023

##### Image Hosting

Lots of S3-compatible storage providers offer free storage quota, but few like [Cloudflare R2](https://developers.cloudflare.com/r2/platform/pricing/) offers free traffic. However, Cloudflare R2 doesn't support S3 ACL feature, so we have to tweak the Ruby library used by Mastodon to upload files to S3 a bit, like what I did in Dockerfile:

```Dockerfile
# disable s3 acl to make it compatibible w/ cloudflare r2
RUN sed -i'' '/acl:/d' /opt/mastodon/vendor/bundle/ruby/3.0.0/gems/kt-paperclip-7.1.1/lib/paperclip/storage/s3.rb
```
