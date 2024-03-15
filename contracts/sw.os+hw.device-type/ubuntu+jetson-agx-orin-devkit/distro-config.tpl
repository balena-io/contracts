RUN echo "deb https://repo.download.nvidia.com/jetson/common r35.4 main" >>  /etc/apt/sources.list.d/nvidia.list \
	&& echo "deb https://repo.download.nvidia.com/jetson/t234 r35.4 main" >>  /etc/apt/sources.list.d/nvidia.list \
	&& apt-key adv --fetch-key http://repo.download.nvidia.com/jetson/jetson-ota-public.asc \
	&& mkdir -p /opt/nvidia/l4t-packages/ && touch /opt/nvidia/l4t-packages/.nv-l4t-disable-boot-fw-update-in-preinstall
