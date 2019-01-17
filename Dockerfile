FROM alpine:3.8

LABEL maintainer="Thomas Schwärzl <thomas.schwaerzl@nttdata.com>"
# based on the work of Christoph Görn <goern@b4mad.net>
# based on the work of Takayoshi Kimura <tkimura@redhat.com>

ENV container docker
ENV MATTERMOST_VERSION 5.6.3
ENV MATTERMOST_VERSION_SHORT 563
ARG PUID=2000
ARG PGID=2000

# Labels consumed by Red Hat build service
LABEL Component="mattermost" \
      name="alpine/mattermost-${MATTERMOST_VERSION_SHORT}-alpine38" \
      vendor=Community \
      Version="${MATTERMOST_VERSION}" \
      Release="1"

# Labels could be consumed by OpenShift
LABEL io.k8s.description="Mattermost is an open source, self-hosted Slack-alternative" \
      io.k8s.display-name="Mattermost {$MATTERMOST_VERSION}" \
      io.openshift.expose-services="8065:mattermost" \
      io.openshift.tags="mattermost,slack"

# Install some needed packages
RUN apk add --no-cache \
	ca-certificates \
	curl \
	jq \
	libc6-compat \
	libffi-dev \
	linux-headers \
	mailcap \
	netcat-openbsd \
	xmlsec-dev \
	&& rm -rf /tmp/*

RUN mkdir -p /opt && \
    cd /opt && \
    curl -LO -v https://releases.mattermost.com/${MATTERMOST_VERSION}/mattermost-team-${MATTERMOST_VERSION}-linux-amd64.tar.gz && \
    tar xf mattermost-team-${MATTERMOST_VERSION}-linux-amd64.tar.gz &&\
    rm mattermost-team-${MATTERMOST_VERSION}-linux-amd64.tar.gz

COPY config.json /opt/mattermost/config/config.json

COPY mattermost-launch.sh /opt/mattermost/bin/mattermost-launch.sh

RUN chmod 777 /opt/mattermost/config/config.json && \
    mkdir -p /opt/mattermost/data /opt/mattermost/plugins /opt/mattermost/client/plugins && \
    chmod 777 /opt/mattermost/logs/ /opt/mattermost/data /opt/mattermost/plugins /opt/mattermost/client/plugins

RUN addgroup -g ${PGID} mattermost \
    && adduser -D -u ${PUID} -G mattermost -h /opt/mattermost -D mattermost

USER 2000

EXPOSE 8065

WORKDIR /opt/mattermost

CMD [ "/opt/mattermost/bin/mattermost-launch.sh" ]