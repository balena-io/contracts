{{#hw.device-type}}
# How to use this image with Balena

This [guide][getting-started] can help you get started with using this base image with balena, there are also some cool [example projects][example-projects] that will give you an idea what can be done with balena.
{{/hw.device-type}}

# What is Python?

{{sw.stack.data.introduction}}

> [wikipedia.org/wiki/Python_(programming_language)](https://en.wikipedia.org/wiki/Python_%28programming_language%29)

![logo]({{sw.stack.data.logo}}).

{{#hw.device-type}}
{{import partial="dockerhub" combination="sw.stack+hw.device-type+balenalib"}}
{{/hw.device-type}}
{{#arch.sw}}
{{import partial="dockerhub" combination="sw.stack+arch.sw+balenalib"}}
{{/arch.sw}}

[example-projects]: https://www.balena.io/docs/learn/getting-started/{{hw.device-type.slug}}/python/#example-projects?ref=dockerhub
[getting-started]: https://www.balena.io/docs/learn/getting-started/{{hw.device-type.slug}}/python/?ref=dockerhub
