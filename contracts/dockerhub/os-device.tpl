{{#hw.device-type}}
# How to use this image with Balena

This [guide][getting-started] can help you get started with using this base image with balena, there are also some cool [example projects][example-projects] that will give you an idea what can be done with balena.
{{/hw.device-type}}

# Supported versions and respective `Dockerfile` links :

[{{sw.os.data.versionList}}](https://github.com/balena-io-library/base-images/tree/master/balena-base-images/device-base/{{hw.device-type.slug}}/{{sw.os.slug}}/)

For more information about this image and its history, please see the [relevant manifest file (`{{hw.device-type.slug}}-{{sw.os.slug}}`)](https://github.com/balena-io-library/official-images/blob/master/library/{{hw.device-type.slug}}-{{sw.os.slug}}) in the [`balena-io-library/official-images` GitHub repo](https://github.com/balena-io-library/official-images).

# How to use this image

### Create a `Dockerfile` in your app project

```dockerfile
FROM balenalib/{{hw.device-type.slug}}-{{sw.os.slug}}:latest
# replace this with your application
```

You can then build and run the Docker image:

```console
$ docker build -t my-app .
$ docker run -it --rm --name my-running-app my-app
```

[example-projects]: https://www.balena.io/docs/learn/getting-started/{{hw.device-type.slug}}/nodejs/#example-projects?ref=dockerhub
[getting-started]: https://www.balena.io/docs/learn/getting-started/{{hw.device-type.slug}}/nodejs/?ref=dockerhub
