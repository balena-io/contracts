## v1.0.0 - 2018-09-06

* Package.json: Add private: true to stop publishing to npm [Trong Nghia Nguyen]
* Device: Add new contract for Revolution Pi Core 3 [Trong Nghia Nguyen]
* Device: Add new contract for Stem x86 32bit [Trong Nghia Nguyen]
* Qemu: Update qemu to v3.0.0+resin [Trong Nghia Nguyen]

## 1.1.10 - 2018-11-19

* Nanopi-neo-air: Mention wifi support [Alexandru Costache]
* Var-som-mx6: Mention wifi support [Alexandru Costache]
* NewDevice: Add info for imx7-var-som [Alexandru Costache]

## 1.1.9 - 2018-11-13

* NewDevice: Add info for nanopi-neo-air [Trong Nghia Nguyen]

## 1.1.8 - 2018-11-09

* Python: Add info of openssl1.1 supported binary for python v2.7.15 v3.4.9 v3.5.6 and v3.6.6 [Trong Nghia Nguyen]
* Golang: Add info for Golang v1.11.1 [Trong Nghia Nguyen]

## 1.1.7 - 2018-11-06

* New-device: Add contract for var-som-mx6 [Trong Nghia Nguyen]
* Circleci: Update circleci config 2.0 [Trong Nghia Nguyen]

## 1.1.6 - 2018-11-05

* Circleci: Update circleci config 2.0 [Trong Nghia Nguyen]
* BaseImages: Fix install_packages on Alpine and Fedora partials [Trong Nghia Nguyen]
* BaseImages: Add gnupg to base dependencies for Alpine and Fedora [Trong Nghia Nguyen]

## v1.1.5 - 2018-10-28

* Rpi: Change raspbian key server in rpi debian images [Trong Nghia Nguyen]
* Fedora: Remove fedora 27 due to dnf issue [Trong Nghia Nguyen]
* Beaglebone: No longer install package from oldstable replease [Trong Nghia Nguyen]

## v1.1.4 - 2018-10-25

* Namechange: Rename some stuff from resin to balena [Trong Nghia Nguyen]
* Fedora: Some os-config must be applied before installing packages [Trong Nghia Nguyen]
* Contracts: Use `this` in template reference inside contract [Trong Nghia Nguyen]

## v1.1.3 - 2018-10-24

* BaseImages: Remove deprecation warning for resin base images [Trong Nghia Nguyen]

## v1.1.2 - 2018-10-23

* Contracts: various small updates [Trong Nghia Nguyen]
* Openjdk: Add contracts and partials for OpenJDK stack [Trong Nghia Nguyen]
* Golang: Add contract and partials for golang stack [Trong Nghia Nguyen]
* Python: Add contract and partials for Python stack [Trong Nghia Nguyen]
* Namechange: Change xbuild partial to balena-xbuild [Trong Nghia Nguyen]
* Partials: Few partial updates for node stack [Trong Nghia Nguyen]
* Version: Add latest version for some contracts [Trong Nghia Nguyen]
* Balena-xbuild: Change resin-xbuild to balena-xbuild [Trong Nghia Nguyen]
* Entry-script: Update entry script contract for balena base images [Trong Nghia Nguyen]
* Debian: Drop support for Debian Wheezy [Trong Nghia Nguyen]
* Node: Add contracts and partials for nodejs base image stack [Trong Nghia Nguyen]
* Os: Remove tini and initsystem related partials [Trong Nghia Nguyen]
* Blob: Remove tini contracts [Trong Nghia Nguyen]
* Os: add install_packages script to os partials [Trong Nghia Nguyen]
* Os: Update default env vars [Trong Nghia Nguyen]

## v1.1.1 - 2018-10-23

* Base-images: Add deprecation warning when using resin base images [Trong Nghia Nguyen]

## v1.1.0 - 2018-09-25

* Device: Add contract for asus-tinker-board and asus-tinker-board-s [Trong Nghia Nguyen]

* Base-image: Specify package repository when installing default packages [Trong Nghia Nguyen]
* Device: add contract for new device - CTI Spacely TX2 [Trong Nghia Nguyen]
* Add contract for new device: CTI Orbitty TX2 [Trong Nghia Nguyen]
* Add rpi and armv7hf to the supported architecture list of Alpine Linux. They are identical (based on arm32v6/alpine) but kept separate to support mixed-device fleet. [Trong Nghia Nguyen]
* Remove armhf from architecture contracts (Only keeps what /config endpoint returns). [Trong Nghia Nguyen]
* Add contract and partials for ubuntu. [Trong Nghia Nguyen]
* Add artik530 contract to hw.device-type. [Trong Nghia Nguyen]
* Add artik533s contract to hw.device-type. [Trong Nghia Nguyen]
* Add fincm3 contract to hw.device-type. [Trong Nghia Nguyen]
* Add orangepi-plus2 contract to hw.device-type. [Trong Nghia Nguyen]
* Add bananapi-m1-plus contract to hw.device-type [Horia Delicoti]
