# Supported versions and respective `Dockerfile` links :

[{{sw.stack.data.versionList}}](https://github.com/balena-io-library/base-images/tree/master/balena-base-images/{{sw.stack.slug}}/{{hw.device-type.slug}}/{{sw.os.slug}}/)

For more information about this image and its history, please see the [relevant manifest file (`{{hw.device-type.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}`)](https://github.com/balena-io-library/official-images/blob/master/library/{{hw.device-type.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}) in the [`balena-io-library/official-images` GitHub repo](https://github.com/balena-io-library/official-images).

# How to use this image

## Start a Go instance in your app

The most straightforward way to use this image is to use a Go container as both the build and runtime environment. In your `Dockerfile`, writing something along the lines of the following will compile and run your project:

```dockerfile
FROM balenalib/{{hw.device-type.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}:latest

WORKDIR /go/src/app
COPY . .

RUN go get -d -v ./...
RUN go install -v ./...

CMD ["app"]
```

You can then build and run the Docker image:

```console
$ docker build -t my-golang-app .
$ docker run -it --rm --name my-running-app my-golang-app
```

## Compile your app inside the Docker container

There may be occasions where it is not appropriate to run your app inside a container. To compile, but not run your app inside the Docker instance, you can write something like:

```console
$ docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp balenalib/{{hw.device-type.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}:latest go build -v
```

This will add your current directory as a volume to the container, set the working directory to the volume, and run the command `go build` which will tell go to compile the project in the working directory and output the executable to `myapp`.
