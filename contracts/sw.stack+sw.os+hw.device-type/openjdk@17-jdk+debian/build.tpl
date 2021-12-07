# A few reasons for installing distribution-provided OpenJDK:
#
#  1. Oracle.  Licensing prevents us from redistributing the official JDK.
#
#  2. Compiling OpenJDK also requires the JDK to be installed, and it gets
#     really hairy.
#
#     For some sample build times, see Debian's buildd logs:
#       https://buildd.debian.org/status/logs.php?pkg=openjdk-8

RUN apt-get update && apt-get install -y --no-install-recommends \
		bzip2 \
		unzip \
		xz-utils \
		binutils \
		fontconfig libfreetype6 \
		ca-certificates p11-kit \
	&& rm -rf /var/lib/apt/lists/*

ENV JAVA_HOME /usr/local/openjdk-16
ENV PATH $JAVA_HOME/bin:$PATH

# Default to UTF-8 file.encoding
ENV LANG C.UTF-8

RUN curl -SLO "{{sw.stack.assets.bin.url}}" \
	&& echo "{{sw.stack.assets.bin.checksum}}  {{sw.stack.assets.bin.name}}" | sha256sum -c - \
	&& mkdir -p "$JAVA_HOME" \
	&& tar --extract \
		--file {{sw.stack.assets.bin.name}} \
		--directory "$JAVA_HOME" \
		--strip-components 1 \
		--no-same-owner \
	&& rm -f {{sw.stack.assets.bin.name}} \
	&& { \
		echo '#!/usr/bin/env bash'; \
		echo 'set -Eeuo pipefail'; \
		echo 'trust extract --overwrite --format=java-cacerts --filter=ca-anchors --purpose=server-auth "$JAVA_HOME/lib/security/cacerts"'; \
	} > /etc/ca-certificates/update.d/docker-openjdk \
	&& chmod +x /etc/ca-certificates/update.d/docker-openjdk \
	&& /etc/ca-certificates/update.d/docker-openjdk \
	&& find "$JAVA_HOME/lib" -name '*.so' -exec dirname '{}' ';' | sort -u > /etc/ld.so.conf.d/docker-openjdk.conf \
	&& ldconfig \
	&& java -Xshare:dump \
	&& fileEncoding="$(echo 'System.out.println(System.getProperty("file.encoding"))' | jshell -s -)"; [ "$fileEncoding" = 'UTF-8' ]; rm -rf ~/.java \
	&& javac --version \
	&& java --version
