# Supported versions and respective `Dockerfile` links :

[{{sw.os.data.versionList}}](https://github.com/balena-io-library/base-images/tree/master/balena-base-images/{{arch.sw.slug}}/{{sw.os.slug}}/)

For more information about this image and its history, please see the [relevant manifest file (`{{arch.sw.slug}}-{{sw.os.slug}}`)](https://github.com/balena-io-library/official-images/blob/master/library/{{arch.sw.slug}}-{{sw.os.slug}}) in the [`balena-io-library/official-images` GitHub repo](https://github.com/balena-io-library/official-images).

# How to use this image

### Create a `Dockerfile` in your app project

```dockerfile
FROM balenalib/{{arch.sw.slug}}-{{sw.os.slug}}:latest
# replace this with your application
```

You can then build and run the Docker image:

```console
$ docker build -t my-app .
$ docker run -it --rm --name my-running-app my-app
```
