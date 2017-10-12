# Config OpenRC
RUN sed -i '/tty/d' /etc/inittab

RUN echo $'# Global OpenRC configuration settings \n\
# Ref: https://github.com/OpenRC/openrc/tree/master/etc \n\
rc_env_allow=* \n\
rc_crashed_stop=NO \n\
rc_crashed_start=YES \n\
rc_provide="loopback net" \n\
rc_sys="lxc" \n\
rc_tty_number=12' > /etc/rc.conf

COPY resin /etc/init.d/

RUN rc-update add resin default \
	&& rc-update add dbus default

COPY entry.sh /usr/bin/entry.sh

ENTRYPOINT ["/usr/bin/entry.sh"]
