FROM docker:dind
ARG DF_VERSION=1.0.6
RUN WORKDIR=$(mktemp -d) && cd ${WORKDIR} && \
  wget https://github.com/dragonflyoss/Dragonfly/releases/download/v${DF_VERSION}/Dragonfly_${DF_VERSION}_linux_amd64.tar.gz && \
  tar zxvf Dragonfly_${DF_VERSION}_linux_amd64.tar.gz && \
  mv Dragonfly_${DF_VERSION}_linux_amd64/dfget /usr/local/bin/ && \
  mv Dragonfly_${DF_VERSION}_linux_amd64/dfdaemon /usr/local/bin && \
  mv Dragonfly_${DF_VERSION}_linux_amd64/supernode /usr/local/bin && \
  cd - && rm -rf ${WORKDIR}

