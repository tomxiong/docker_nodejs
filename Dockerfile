# Use tomxiong/docker-baseimage as base image. To make your builds reproducible, make
# sure you lock down to a specific version, not to `latest`!
FROM tomxiong/docker-baseimage:latest

# Set correct environment variables.
ENV HOME /root
ENV NODEJS_VERSION 0.10.35

# Regenerate SSH host keys. baseimage-docker does not contain any, so you
# have to do that yourself. You may also comment out this instruction; the
# init system will auto-generate one during boot.
#RUN /etc/my_init.d/00_regen_ssh_host_keys.sh

# Use baseimage-docker's init system.
CMD ["/sbin/my_init"]

# ...put your own build instructions here...
# Prepare install environment of nodejs 0.10.35 or variable paramter(TODO)
RUN apt-get update -y && apt-get install --no-install-recommends -y -q curl python build-essential git ca-certificates wget unzip
RUN mkdir /nodejs && curl http://nodejs.org/dist/v$NODEJS_VERSION/node-v$NODEJS_VERSION-linux-x64.tar.gz | tar xvzf - -C /nodejs --strip-components=1
RUN mkdir /app
ADD app.js /app/index.js

ENV PATH $PATH:/nodejs/bin

# Clean up APT when done.
RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
