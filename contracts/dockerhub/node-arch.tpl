# Supported versions and respective `Dockerfile` links :

[{{sw.stack.data.versionList}}](https://github.com/balena-io-library/base-images/tree/master/balena-base-images/{{sw.stack.slug}}/{{arch.sw.slug}}/{{sw.os.slug}}/)

For more information about this image and its history, please see the [relevant manifest file (`{{arch.sw.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}`)](https://github.com/balena-io-library/official-images/blob/master/library/{{arch.sw.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}) in the [`balena-io-library/official-images` GitHub repo](https://github.com/balena-io-library/official-images).

# How to use this image

### Create a `Dockerfile` in your Node.js app project

```dockerfile
# specify the {{sw.stack.slug}} base image with your desired version {{sw.stack.slug}}:<version>
FROM balenalib/{{arch.sw.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}:latest
# replace this with your application's default port
EXPOSE 8888
```

You can then build and run the Docker image:

```console
$ docker build -t my-nodejs-app .
$ docker run -it --rm --name my-running-app my-nodejs-app
```

If you prefer Docker Compose:

```yml
version: "2"
services:
  {{sw.stack.slug}}:
    image: "balenalib/{{arch.sw.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}:latest"
    user: "{{sw.stack.slug}}"
    working_dir: /home/{{sw.stack.slug}}/app
    environment:
      - NODE_ENV=production
    volumes:
      - ./:/home/{{sw.stack.slug}}/app
    expose:
      - "8081"
    command: "npm start"
```

You can then run using Docker Compose:

```console
$ docker-compose up -d
```

Docker Compose example copies your current directory (including node_modules) to the container.
It assumes that your application has a file named [`package.json`](https://docs.npmjs.com/files/package.json)
defining [start script](https://docs.npmjs.com/misc/scripts#default-values).

### Run a single Node.js script

For many simple, single file projects, you may find it inconvenient to write a
complete `Dockerfile`. In such cases, you can run a Node.js script by using the
Node.js Docker image directly:

```console
$ docker run -it --rm --name my-running-script -v "$PWD":/usr/src/app -w /usr/src/app balenalib/{{arch.sw.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}:latest node your-daemon-or-script.js
```
