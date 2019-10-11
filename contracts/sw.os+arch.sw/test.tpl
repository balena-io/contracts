RUN curl -SLO "{{sw.os.assets.test.url}}" \
  && echo "Running {{sw.os.assets.test.main}}" \
  && chmod +x {{sw.os.assets.test.name}} \
  && bash {{sw.os.assets.test.name}} {{sw.os.slug}} {{sw.os.version}} \
  && rm -rf {{sw.os.assets.test.name}}
