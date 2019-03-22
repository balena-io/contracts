{{#hw.device-type}}
# How to use this image with Balena

This [guide][getting-started] can help you get started with using this base image with balena, there are also some cool [example projects][example-projects] that will give you an idea what can be done with balena.
{{/hw.device-type}}

# What is Go?

Go (a.k.a., Golang) is a programming language first developed at Google. It is a statically-typed language with syntax loosely derived from C, but with additional features such as garbage collection, type safety, some dynamic-typing capabilities, additional built-in types (e.g., variable-length arrays and key-value maps), and a large standard library.

> [wikipedia.org/wiki/Go_(programming_language)](http://en.wikipedia.org/wiki/Go_%28programming_language%29)

![logo](https://raw.githubusercontent.com/docker-library/docs/01c12653951b2fe592c1f93a13b4e289ada0e3a1/golang/logo.png)

{{#hw.device-type}}
{{import partial="golang-device" combination="dockerhub"}}
{{/hw.device-type}}
{{#arch.sw}}
{{import partial="golang-arch" combination="dockerhub"}}
{{/arch.sw}}

[example-projects]: https://www.balena.io/docs/learn/getting-started/{{hw.device-type.slug}}/go/#example-projects?ref=dockerhub
[getting-started]: https://www.balena.io/docs/learn/getting-started/{{hw.device-type.slug}}/go/?ref=dockerhub
