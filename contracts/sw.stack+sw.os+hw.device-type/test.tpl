RUN curl -SLO "{{sw.stack.assets.test.url}}" \
  && echo "Running {{sw.stack.assets.test.main}}" \
  && chmod +x {{sw.stack.assets.test.name}} \
  && bash {{sw.stack.assets.test.name}} \
  && rm -rf {{sw.stack.assets.test.name}}
