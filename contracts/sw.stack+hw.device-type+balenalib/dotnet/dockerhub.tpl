# Supported versions and respective `Dockerfile` links :

[{{sw.stack.data.versionList}}](https://github.com/balena-io-library/base-images/tree/master/balena-base-images/{{sw.stack.slug}}/{{hw.device-type.slug}}/{{sw.os.slug}}/)

For more information about this image and its history, please see the [relevant manifest file (`{{hw.device-type.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}`)](https://github.com/balena-io-library/official-images/blob/master/library/{{hw.device-type.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}) in the [`balena-io-library/official-images` GitHub repo](https://github.com/balena-io-library/official-images).

# How to use this image

### Create a `Dockerfile` in your dotnet app project

```dockerfile
# specify the {{sw.stack.slug}} base image with your desired version {{sw.stack.slug}}:<version>
FROM balenalib/{{hw.device-type.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}:latest
# replace this with your application's default port
EXPOSE 8000
```

You can then build and run the Docker image:

```console
$ docker build -t my-dotnet-app .
$ docker run -it --rm --name my-running-app my-dotnet-app
```

If you prefer Docker Compose:

```yml
version: "2"
services:
  {{sw.stack.slug}}:
    image: "balenalib/{{hw.device-type.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}:latest"
    user: "{{sw.stack.slug}}"
    working_dir: /home/{{sw.stack.slug}}/app
    volumes:
      - ./:/home/{{sw.stack.slug}}/app
    expose:
      - "8000"
```

You can then run using Docker Compose:

```console
$ docker-compose up -d
```
