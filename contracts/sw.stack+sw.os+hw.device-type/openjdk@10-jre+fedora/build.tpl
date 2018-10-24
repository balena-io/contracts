RUN dnf -y update \
	&& dnf clean all \
	&& dnf -y install \
		gzip \
		java-openjdk \
		tar \
	&& dnf clean all

# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-openjdk
