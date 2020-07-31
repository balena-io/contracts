RUN echo "deb http://archive.raspberrypi.org/debian {{sw.os.version}} main ui" >>  /etc/apt/sources.list.d/raspi.list \
	&& apt-key adv --batch --keyserver ha.pool.sks-keyservers.net  --recv-key 0x82B129927FA3303E
