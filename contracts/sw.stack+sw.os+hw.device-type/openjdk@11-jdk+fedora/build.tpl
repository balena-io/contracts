RUN dnf -y update \
	&& dnf clean all \
	&& dnf -y install \
		gzip \
		java-11-openjdk \
		java-11-openjdk-devel \
		tar \
	&& dnf clean all

# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-openjdk
