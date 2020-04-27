RUN [ ! -d /.balena/messages ] && mkdir -p /.balena/messages; echo 'Here are a few details about this Docker image (For more information please visit https://www.balena.io/docs/reference/base-images/base-images/): \nArchitecture: {{arch.sw.name}} \nOS: {{sw.os.name}} \nVariant: {{sw.stack-variant.name}} \nDefault variable(s): UDEV=off \nThe following software stack is preinstalled: \n{{sw.stack.assets.manifest}} \nExtra features: \n- Easy way to install packages with `install_packages <package-name>` command \n- Run anywhere with cross-build feature  (for ARM only)' > /.balena/messages/image-info

RUN echo '#!/bin/sh.real\nbalena-info\nrm -f /bin/sh\ncp /bin/sh.real /bin/sh\n/bin/sh "$@"' > /bin/sh-shim \
	&& chmod +x /bin/sh-shim \
	&& cp /bin/sh /bin/sh.real \
	&& mv /bin/sh-shim /bin/sh 