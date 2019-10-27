FROM node:lts-alpine

ENV HUGO_VERSION=0.59.0
ENV HUGO_PACKAGE=hugo_extended_${HUGO_VERSION}_Linux-64bit.tar.gz

WORKDIR /workspace

COPY package.json package.json
COPY package-lock.json package-lock.json

RUN set -xe \
    && apk add --no-cache --virtual .build-deps \
        wget \
    && apk add --no-cache \
        git \
        ca-certificates \
        libc6-compat \
        libstdc++ \
    && npm install --cache /tmp/npm-cache \
    && wget --quiet -P /tmp https://github.com/gohugoio/hugo/releases/download/v${HUGO_VERSION}/${HUGO_PACKAGE} \
    && tar xzvf "/tmp/${HUGO_PACKAGE}" hugo -C /usr/local/bin \
    && apk del .build-deps \
    && rm -rf \
        /tmp/* \
        /usr/includes/* \
        /usr/share/man/* \
        /usr/src/* \
        /var/cache/apk/* \
        /var/tmp/* \
    && npm version \
    && node --version \
    && git --version \
    && hugo version

COPY archetypes archetypes
COPY assets assets
COPY config config
COPY layouts layouts
COPY static static
COPY .browserslistrc .browserslistrc
COPY .postcssrc.js .postcssrc.js

COPY docker-entrypoint.sh /
RUN set -xe \
    && chmod +x /docker-entrypoint.sh

EXPOSE 1313

ENTRYPOINT ["/docker-entrypoint.sh"]
CMD ["server"]
