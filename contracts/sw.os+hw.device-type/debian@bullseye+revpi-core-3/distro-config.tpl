RUN echo "deb http://archive.raspbian.org/raspbian {{sw.os.version}} main contrib non-free rpi firmware" >>  /etc/apt/sources.list \
	&& apt-key adv --batch --keyserver ha.pool.sks-keyservers.net  --recv-key 0x9165938D90FDDD2E
