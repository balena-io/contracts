Balena Base Contracts
=======================

The collection of contracts and partials across the balena system.

Contracts
---------

Each contract is a `.json` file inside the `contracts/` directory. The
convention is to store one contract per file, located in
`contracts/<type>/<slug>.json`.

Partials
--------

This directory contains partials that apply to certain combinations of
contracts. The convention is to store a partial in
`partials/<combination>/<combination instantiation>/<partial>.tpl`. Here are
some examples:

```
partials/sw.os+arch.sw/debian+amd64/installation.tpl
partials/sw.os+arch.sw/debian/installation.tpl
partials/hw.device-type/ts4900/remove-install-media.tpl
```

The combination section defines the types of contracts that come into play for
a particular partials subtree, separated by a `+` symbol. If the combination is
`sw.os+arch.sw`, then it means that the subtree will take into account the
combination of operating systems and architectures. Note that there can be
combinations of a single type.

The combination instantiation section defines a subtree for a specific set of
contracts that match the combination type. If the combination is
`sw.os+arch.sw`, a valid combination instantiation can be `debian+amd64`, which
is the subtree that will be selected when matching the Debian GNU/Linux
contract with the amd64 architecture contract.

Note that a combination instantiation may use `@` symbols to define subtrees
for a specific version of one or more contracts in the combination. For
example, `debian@wheezy+amd64` will be the subtree containing partials for the
combination of Debian Wheezy and amd64.

You can also omit trailing portions of the combination instantiation to
implement wildcards. If the combination is `sw.os+arch.sw` and the
instantiation is `debian`, it means that such subtree will apply to the
combination of Debian GNU/Linux with *any* architecture.

The partial tree is then traversed from specific to general, until a match is
found. This is the path that the contract system will follow when searching for
the `download` template on the `sw.os+arch.sw` combination:

```
sw.os+arch.sw/<os>@<version>+<arch>@<version>/download.tpl
sw.os+arch.sw/<os>@<version>+<arch>/download.tpl
sw.os+arch.sw/<os>+<arch>@<version>/download.tpl
sw.os+arch.sw/<os>+<arch>/download.tpl
sw.os+arch.sw/<os>/download.tpl
```

## Instruction Partials

With a [recent change](https://github.com/balena-io/contracts/pull/236), several changes were made to the overall contract spec to be able to work around problems happening and being able generate accurate provisioning instructions for device types using contracts. Some information is present below: 

### flashProtocol

If there is a `flashProtocol` defined then we know that we need to flash directly to the device. This process will require no storage media to be attached. After identifying which protocols etcher can or can't support will determine flash protocol for that device type and subsequently the instructions for the device type as well. 

Example, in this case `jetsonFlash` is not supported by etcher so we will need to give jetson flashing specific instructions:

```
    "flashProtocol": "jetsonFlash",
    "media": {
      "defaultBoot": "internal",
      "altBoot": []
    },
```

On the other hand, another example of a `flashProtocol` that Etcher does supports would be `RPIBOOT` which is a flash protocol utilized by balena Fin.

## defaultBoot

>  Defines the medium from which the device boots at runtime.

If the `defaultBoot` is `internal` and there is an alternative boot method like `sdcard` and no `flashProtocol` defined, then we know this is an installation where we need to flash to the `sdcard` with etcher and that sd card will have a flasher image to write to the internal storage
```
    "media": {
      "defaultBoot": "internal",
      "altBoot": ["sdcard"]
    },
```

If the `defaultBoot` is something not `internal` and there is no `flashProtocol` then we know the device will need to boot off of an external media in which we flash BalenaOS onto directly like a raspberry pi might have this definition:
```
    "media": {
      "defaultBoot": "sdcard",
      "altBoot": []
    },
```

There are other defaultBoot implementations as well that are available. 

## altBoot

`altBoot` describes the list of external mediums from which the device can be provisioned, if any of them are available for the DT.

Contribute
----------

- Issue Tracker: [github.com/balena-io/contracts/issues][issues]
- Source Code: [github.com/balena-io/contracts][source]

### Dependencies

- [Node.js][nodejs]


You can perform a set of static analysis checks to find the most common types
of errors by running:

```sh
npm test
```

License
-------

The project is licensed under the Apache 2.0 license.

[issues]: https://github.com/balena-io/contracts/issues
[source]: https://github.com/balena-io/contracts
[nodejs]: https://nodejs.org
