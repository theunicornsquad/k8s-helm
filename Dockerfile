FROM alpine

LABEL maintainer="Paulo André Soares <pauloandresoares@gmail.com>"

ARG VCS_REF
ARG BUILD_DATE

# Metadata
LABEL org.opencontainers.image.title="unicornsquad/k8s-helm" \
      org.opencontainers.image.url="https://helm.sh/docs/" \
      org.opencontainers.image.revision=$VCS_REF \
      org.opencontainers.image.source="https://github.com/theunicornsquad/k8s-helm" \
      org.opencontainers.image.created=$BUILD_DATE

ENV HELM_LATEST_VERSION="v3.1.1"

RUN apk add --update ca-certificates \
 && apk add --update -t deps wget git openssl bash \
 && wget -q https://get.helm.sh/helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
 && tar -xf helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz \
 && mv linux-amd64/helm /usr/local/bin \
 && /usr/local/bin/helm plugin install https://github.com/chartmuseum/helm-push \
 && apk del --purge deps \
 && rm /var/cache/apk/* \
 && rm -f /helm-${HELM_LATEST_VERSION}-linux-amd64.tar.gz

ENTRYPOINT ["helm"]
CMD ["help"]
