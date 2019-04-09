# Supported versions and respective `Dockerfile` links :

[{{sw.stack.data.versionList}}](https://github.com/balena-io-library/base-images/tree/master/balena-base-images/{{sw.stack.slug}}/{{hw.device-type.slug}}/{{sw.os.slug}}/)

For more information about this image and its history, please see the [relevant manifest file (`{{hw.device-type.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}`)](https://github.com/balena-io-library/official-images/blob/master/library/{{hw.device-type.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}) in the [`balena-io-library/official-images` GitHub repo](https://github.com/balena-io-library/official-images).

# How to use this image

## Create a `Dockerfile` in your Python app project

```dockerfile
FROM balenalib/{{hw.device-type.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}:latest

WORKDIR /usr/src/app

COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD [ "python", "./your-daemon-or-script.py" ]
```

You can then build and run the Docker image:

```console
$ docker build -t my-python-app .
$ docker run -it --rm --name my-running-app my-python-app
```

## Run a single Python script

For many simple, single file projects, you may find it inconvenient to write a complete `Dockerfile`. In such cases, you can run a Python script by using the Python Docker image directly:

```console
$ docker run -it --rm --name my-running-script -v "$PWD":/usr/src/myapp -w /usr/src/myapp balenalib/{{hw.device-type.slug}}-{{sw.os.slug}}-{{sw.stack.slug}}:latest python your-daemon-or-script.py
```
