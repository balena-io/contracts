# https://github.com/docker-library/python/issues/147
ENV PYTHONIOENCODING UTF-8

# set PYTHONPATH to point to dist-packages
ENV PYTHONPATH /usr/lib/python2.7/site-packages:$PYTHONPATH
