ENV GO_VERSION {{sw.stack.version}}

# gcc for cgo
RUN apt-get update && apt-get install -y --no-install-recommends \
		g++ \
		gcc \
		libc6-dev \
		make \
		pkg-config \
		git \
	&& rm -rf /var/lib/apt/lists/*

RUN set -x \
	&& fetchDeps=' \
		curl \
	' \
	&& apt-get update && apt-get install -y $fetchDeps --no-install-recommends && rm -rf /var/lib/apt/lists/* \
	&& mkdir -p /usr/local/go \
	&& curl -SLO "{{sw.stack.assets.bin.url}}" \
	&& echo "{{sw.stack.assets.bin.checksum}}  {{sw.stack.assets.bin.name}}" | sha256sum -c - \
	&& tar -xzf "{{sw.stack.assets.bin.name}}" -C /usr/local/go --strip-components=1 \
	&& rm -f {{sw.stack.assets.bin.name}}

ENV GOROOT /usr/local/go
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

RUN mkdir -p "$GOPATH/src" "$GOPATH/bin" && chmod -R 777 "$GOPATH"
WORKDIR $GOPATH
