{{#hw.device-type}}
# How to use this image with Balena

This [guide][getting-started] can help you get started with using this base image with balena, there are also some cool [example projects][example-projects] that will give you an idea what can be done with balena.
{{/hw.device-type}}

# What is Go?

{{sw.stack.data.introduction}}

> [wikipedia.org/wiki/Go_(programming_language)](http://en.wikipedia.org/wiki/Go_%28programming_language%29)

![logo]({{sw.stack.data.logo}})

{{#hw.device-type}}
{{import partial="golang-device" combination="dockerhub"}}
{{/hw.device-type}}
{{#arch.sw}}
{{import partial="golang-arch" combination="dockerhub"}}
{{/arch.sw}}

[example-projects]: https://www.balena.io/docs/learn/getting-started/{{hw.device-type.slug}}/go/#example-projects?ref=dockerhub
[getting-started]: https://www.balena.io/docs/learn/getting-started/{{hw.device-type.slug}}/go/?ref=dockerhub
