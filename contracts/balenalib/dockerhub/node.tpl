{{#hw.device-type}}
# How to use this image with Balena

This [guide][getting-started] can help you get started with using this base image with balena, there are also some cool [example projects][example-projects] that will give you an idea what can be done with balena.
{{/hw.device-type}}

# What is Node.js?

{{sw.stack.data.introduction}}

> [wikipedia.org/wiki/Node.js](https://en.wikipedia.org/wiki/Node.js)

![logo]({{sw.stack.data.logo}}).

{{#hw.device-type}}
{{import partial="dockerhub" combination="sw.stack+hw.device-type+balenalib"}}
{{/hw.device-type}}
{{#arch.sw}}
{{import partial="dockerhub" combination="sw.stack+arch.sw+balenalib"}}
{{/arch.sw}}

[example-projects]: https://www.balena.io/docs/learn/getting-started/{{hw.device-type.slug}}/nodejs/#example-projects?ref=dockerhub
[getting-started]: https://www.balena.io/docs/learn/getting-started/{{hw.device-type.slug}}/nodejs/?ref=dockerhub
