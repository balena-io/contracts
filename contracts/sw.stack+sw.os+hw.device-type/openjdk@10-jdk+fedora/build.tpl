RUN dnf -y update \
	&& dnf clean all \
	&& dnf -y install \
		gzip \
		java-openjdk \
		java-openjdk-devel \
		tar \
	&& dnf clean all

# set JAVA_HOME
ENV JAVA_HOME /usr/lib/jvm/java-openjdk
