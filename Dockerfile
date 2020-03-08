FROM alpine

ARG self
ARG other

ENV script=/tmp/ping_containers
# attempt to ping self, and ${other_container}
ENV bash_syntax="set -x; while :; do ping -c 1 ${self}; ping -c 1 ${other}; sleep 5; done"

RUN \
set -x && \
apk add bash iputils && \
echo "${bash_syntax}" > "${script}" && \
chmod +x "${script}" && \
:

ENTRYPOINT ["/bin/bash", "-c", "${script}"]
