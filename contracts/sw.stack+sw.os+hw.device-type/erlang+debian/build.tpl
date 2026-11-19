ENV ERLANG_VERSION {{sw.stack.version}}
ENV REBAR3_VERSION {{sw.stack.assets.rebar3.version}}

# runtime deps
RUN install_packages libodbc1 libssl1.1 libsctp1 libtinfo5

RUN rootDir='/erlang' \
	&& mkdir -p $rootDir \
	&& curl -SLO "{{sw.stack.assets.bin.url}}" \
	&& echo "{{sw.stack.assets.bin.checksum}}  {{sw.stack.assets.bin.name}}" | sha256sum -c - \
	&& tar -xzf "{{sw.stack.assets.bin.name}}" -C $rootDir --strip-components=1 \
	&& rm -f {{sw.stack.assets.bin.name}} \
	&& cd $rootDir \
	&& install -v ./rebar3 /usr/local/bin/

ENV PATH /erlang/bin:$PATH

CMD ["erl"]
