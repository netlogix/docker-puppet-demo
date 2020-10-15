ARG DOCKER_VERSION=latest
ARG PACKER_VERSION=latest

FROM hashicorp/packer:${PACKER_VERSION} AS packer

FROM docker:${DOCKER_VERSION}
ARG WAIT_FOR_VERSION=master

# Easiest way to retrieve a packer executable, it's not distributed on github
COPY --from=packer /bin/packer /usr/local/bin/packer-bin

# Necessary to run packer only after puppet server has started
RUN wget -O /usr/local/bin/wait-for https://raw.githubusercontent.com/eficode/wait-for/${WAIT_FOR_VERSION}/wait-for \
	&& chmod 0755 /usr/local/bin/wait-for

COPY packer-wrapper.sh /usr/local/bin/packer

ENV PUPPETSERVER_HOSTNAME=puppet

ENTRYPOINT ["packer"]
