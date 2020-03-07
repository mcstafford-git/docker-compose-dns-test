FROM alpine

ARG other_host
ENV script=/tmp/ping-other_host
# bash_syntax attempts to ping self, and ${other_host}
ENV bash_syntax="set -x; ping -c 1 $(hostname -f); ping -c 1 ${other_host};"

RUN \
set -x && \
apk add bash iputils && \
echo "${bash_syntax}" > "${script}" && \
chmod +x "${script}" && \
:

ENTRYPOINT ["/bin/bash", "-c", "${script}"]
