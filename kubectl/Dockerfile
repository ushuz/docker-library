FROM alpine:3

RUN apk add --update --no-cache bash ca-certificates curl gettext git jq yq

ADD arch /opt/arch

ARG KUBECTL_VERSION=v1.28.4

# kubectl
RUN source /opt/arch && echo "ARCH: ${ARCH}" \
    && curl -o /usr/local/bin/kubectl -sSL "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/${ARCH}/kubectl" \
    && chmod +x /usr/local/bin/kubectl

# kustomize
RUN source /opt/arch && echo "ARCH: ${ARCH}" \
    && KUSTOMIZE_VERSION=$(curl -s 'https://api.github.com/repos/kubernetes-sigs/kustomize/releases/latest' | jq -r '.tag_name' | sed 's/^kustomize\///') \
    && curl -o - -sSL "https://github.com/kubernetes-sigs/kustomize/releases/download/kustomize%2F${KUSTOMIZE_VERSION}/kustomize_${KUSTOMIZE_VERSION}_linux_${ARCH}.tar.gz" \
    | tar x -zv -f - -C /usr/local/bin kustomize
