# remove several traces of python
RUN apk del python*

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# install python dependencies
RUN apk add --no-cache ca-certificates libffi \
	&& apk add --no-cache libssl1.0 || apk add --no-cache libssl1.1

# key 63C7CC90: public key "Simon McVittie <smcv@pseudorandom.co.uk>" imported
# key 3372DCFA: public key "Donald Stufft (dstufft) <donald@stufft.io>" imported
RUN gpg --keyserver keyring.debian.org --recv-keys 4DE8FF2A63C7CC90 \
	&& gpg --keyserver keyserver.ubuntu.com --recv-key 6E3CBCE93372DCFA \
	&& gpg --keyserver keyserver.ubuntu.com --recv-keys 0x52a43a1e4b77b059

# point Python at a system-provided certificate database. Otherwise, we might hit CERTIFICATE_VERIFY_FAILED.
# https://www.python.org/dev/peps/pep-0476/#trust-database
ENV SSL_CERT_FILE /etc/ssl/certs/ca-certificates.crt

ENV PYTHON_VERSION {{sw.stack.version}}

# if this is called "PIP_VERSION", pip explodes with "ValueError: invalid truth value '<VERSION>'"
ENV PYTHON_PIP_VERSION {{sw.stack.assets.pip.version}}

ENV SETUPTOOLS_VERSION {{sw.stack.assets.setuptools.version}}

RUN set -x \
	&& buildDeps=' \
		curl \
		gnupg \
	' \
	&& apk add --no-cache --virtual .build-deps $buildDeps \
	&& curl -SLO "{{sw.stack.assets.bin.url}}" \
	&& echo "{{sw.stack.assets.bin.checksum}}  {{sw.stack.assets.bin.name}}" | sha256sum -c - \
	&& tar -xzf "{{sw.stack.assets.bin.name}}" --strip-components=1 \
	&& rm -rf "{{sw.stack.assets.bin.name}}" \
	&& curl -SL "{{sw.stack.assets.getPip.url}}" -o get-pip.py \
    && echo "{{sw.stack.assets.getPip.checksum}} *get-pip.py" | sha256sum -c - \
    && python3 get-pip.py \
        --disable-pip-version-check \
        --no-cache-dir \
        --no-compile \
        "pip==$PYTHON_PIP_VERSION" \
        "setuptools==$SETUPTOOLS_VERSION" \
	&& rm -f get-pip.py \
	&& find /usr/local \
		\( -type d -a -name test -o -name tests \) \
		-o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
		-exec rm -rf '{}' + \
	&& cd / \
	&& rm -rf /usr/src/python ~/.cache

{{import partial="config" combination="sw.stack+sw.os+hw.device-type"}}
