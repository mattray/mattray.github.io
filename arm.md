---
layout: default
title: 32-bit Arm Chef Infra and Cinc Client Builds for Linux
permalink: /arm/
---

I've been doing builds of Chef and Cinc for 32-bit Arm systems (Raspberry Pi and similar) for awhile, so I figured I'd create a landing page for them. You may download the builds I've made or follow the instructions to make your own.

[Graham Weldon](https://grahamweldon.com/) has taken these instructions and created new **armel** builds for running on [switches](https://www.edge-core.com/productsInfo.php?cls=1&cls2=9&cls3=46&id=21) and other similar hardware. The build scripts do not require additional patches, but Graham has [documented how to create the builds](https://grahamweldon.com/post/2021/01/building-chef-infra-on-cumulus-linux-armel/). Copies of the builds will be hosted here going forward.

# Current Builds

The 32-bit Arm build targets are Debian/Raspbian/Ubuntu on the `armv6l` (Raspberry Pi 1/Zero series) and `armv7hl` (Raspberry Pi 2/3/4 series). CentOS 7 RPMs are also provided for the `armv7hl`. Previous releases of the builds and their instructions are available [here](/old-arm/).

| Version | armv6l DEB | armv7l DEB | armv7l RPM | armel DEB |
|:-|:-|:-|:-|:-|
| **Chef Infra Client 16.11.7** | [chef-16.11.7-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/0el561edvzdrolc/chef-16.11.7-rpi-armv6l_armhf.deb?raw=1) | [chef-16.11.7-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/a2h2p332ii5x1kh/chef-16.11.7-rpi3-armv7l_armhf.deb?raw=1) | [chef-16.11.7-1.el7.armv7hl.rpm](https://www.dropbox.com/s/oygtq4etouun406/chef-16.11.7-1.el7.armv7hl.rpm?raw=1) | [chef-16.11.7-armel.deb COMING SOON] |
| **Cinc Client 16.11.7** | [cinc-16.11.7-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/voke91ji4h06ba2/cinc-16.11.7-rpi-armv6l_armhf.deb?raw=1) | [cinc-16.11.7-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/5915ebsd95btkul/cinc-16.11.7-rpi3-armv7l_armhf.deb?raw=1) | [cinc-16.11.7-1.el7.armv7hl.rpm](https://www.dropbox.com/s/vcfbci1zr9qkiaz/cinc-16.11.7-1.el7.armv7hl.rpm?raw=1) | [cinc-16.11.7-armel.deb COMING SOON] |
| **Chef Infra Client 15.15.0** | [chef-15.15.0-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/m4cxtfs5l22x698/chef-15.15.0-rpi-armv6l_armhf.deb?raw=1) | [chef-15.15.0-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/j2sisrcmow0m7bj/chef-15.15.0-rpi3-armv7l_armhf.deb?raw=1) | [chef-15.15.0-1.el7.armv7hl.rpm](https://www.dropbox.com/s/nz2ooxu715dmyym/chef-15.15.0-1.el7.armv7hl.rpm?raw=1) |
| **Cinc Client 15.15.0** | [cinc-15.15.0-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/kqbs0ewsh4xpo0d/cinc-15.15.0-rpi-armv6l_armhf.deb?raw=1) | [cinc-15.15.0-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/pydw9zwztdhqow0/cinc-15.15.0-rpi3-armv7l_armhf.deb?raw=1) | [cinc-15.15.0-1.el7.armv7hl.rpm](https://www.dropbox.com/s/5evgbwug9rxn2c2/cinc-15.15.0-1.el7.armv7hl.rpm?raw=1) |

# Building with Omnibus

The [Chef](https://github.com/chef/chef) client is packaged with [Omnibus](https://github.com/chef/omnibus), which builds the application and all of its runtime dependencies with the [Omnibus-Toolchain](https://github.com/chef/omnibus-toolchain). Omnibus is built with Ruby, so the instructions start with building Ruby. These instructions assume you have already installed either [Debian 9](/2019/01/29/installing-debian-9-7-on-a-beaglebone-black), [Raspbian 10](/2019/09/14/installing-raspbian-10-on-a-raspberry-pi), or [CentOS 7](/2019/05/07/installing-centos-7-6-on-a-raspberry-pi-three) on your system already.

## Preparation

There are several steps that need to be done before we get started. As the `root` user update to ensure the latest packages are installed and install the prerequisites for building Ruby and Omnibus-Toolchain.

For CentOS:

    yum update
    yum install -y autoconf automake bison flex gcc gcc-c++ gdbm-devel gettext git kernel-devel libffi-devel libyaml-devel m4 make ncurses-devel openssl-devel patch readline-devel rpm-build wget zlib-devel

For Debian/Raspbian:

    apt-get update
    apt-get upgrade
    apt-get install -y autoconf build-essential fakeroot git libreadline-dev libssl-dev zlib1g-dev

## ld.so.preload

Raspbian sets the file `/etc/ld.so.preload` to

    /usr/lib/arm-linux-gnueabihf/libarmmem-${PLATFORM}.so

in an attempt to support both the 6l and 7l armhf platforms. This breaks the Chef 32-bit Arm builds on Raspbian so I have replaced this line with

    echo /usr/lib/arm-linux-gnueabihf/libarmmem-v7l.so > /etc/ld.so.preload

on the Raspberry Pi 3 and 4 and

    echo /usr/lib/arm-linux-gnueabihf/libarmmem-v6l.so > /etc/ld.so.preload

on the Raspberry Pi Zero.

## Omnibus User

Add the `omnibus` user for performing the builds.

    adduser omnibus

Ensure the `omnibus` user has `sudo` privileges and add the following file to `/etc/sudoers.d/omnibus`. Feel free to use the `wheel` group or more limited permissions as necessary.

    omnibus  ALL=(ALL)       NOPASSWD: ALL

You can now `sudo su - omnibus` and continue without changing users.


# Build Scripts

If you want detailed instructions for the steps for building on these platforms check out [Chef 15 Build Instructions for 32-bit Arm](/2019/05/18/chef-15-on-arm). The build is currently Ruby 2.7.2 and does not require any additional patches. To build a specific version, you provide an environment variable `VERSION` before executing the script. I typically run them as the `omnibus` user with something similar to `VERSION=16.11.7 nohup bash RPM-chef-cinc.sh &` and `tail -f nohup.out` to monitor the output.

DEB Build Script: [DEB-chef-cinc.sh](/assets/DEB-chef-cinc.sh)

RPM Build Script: [RPM-chef-cinc.sh](/assets/RPM-chef-cinc.sh)

Build scripts for previous releases are available [here](/old-arm/).

# Additional Notes

## GPU Memory Usage

Because my systems are used primarily has headless servers, I've configured them to use less GPU memory by setting

    gpu_mem=16

in the `/boot/config.txt`. I do this in the [mattray::raspberrypi](https://github.com/mattray/mattray-cookbook/blob/master/recipes/raspberrypi.rb#L59) recipe used by all of my Raspbian systems.

## Chef LEDs Handler Cookbook

If you're using these builds you might be interested in the LEDs Handler cookbook. At the beginning of the Chef client run the LEDs blink a heartbeat pattern and at the end of the client run the LEDs are disabled. If the Chef client run fails the LEDs all stay on. It's pretty simple but it's a fun notification that the nodes are converging. It also works with Mac laptops running Linux, lighting up their keyboards when the Chef client is active.

<a href="https://github.com/mattray/leds_handler-cookbook"><img src="/assets/flashing_leds.gif" alt="Flashing LEDs" width="213" height="120" align="right" /></a>

[https://github.com/mattray/leds_handler-cookbook](https://github.com/mattray/leds_handler-cookbook)
