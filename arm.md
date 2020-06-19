---
layout: default
title: 32-bit ARM Chef Infra and Cinc Client Builds for Linux
permalink: /arm/
---

I've been doing builds of Chef and Cinc for 32-bit ARM systems (Raspberry Pi and similar) for awhile, so I figured I'd create a landing page for them. You may download the builds I've made or follow the instructions to make your own.

# Available Builds

The 32-bit ARM build targets are Debian/Raspbian/Ubuntu on the ARMv6l (Raspberry Pi 1/Zero series) and ARMv7hl (Raspberry Pi 2/3/4 series). CentOS 7 RPMs are also provided for the ARMv7hl.
n
| Version | ARMv6l DEB | ARMv7l DEB | ARMv7l RPM |
|:-|:-|:-|:-|

| Chef Infra 16.2.44 | [chef-16.2.44-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/b8rmvu2t7u813vr/chef-16.2.44-rpi-armv6l_armhf.deb?raw=1) | [chef-16.2.44-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/qghjhnd2ei7ibkp/chef-16.2.44-rpi3-armv7l_armhf.deb?raw=1) | [chef-16.2.44-1.el7.armv7hl.rpm](https://www.dropbox.com/s/v7znbxlkzzcwbj9/chef-16.2.44-1.el7.armv7hl.rpm?raw=1) |
| Cinc 16.2.44 | [cinc-16.2.44-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/wwth6b56l282t8w/cinc-16.2.44-rpi3-armv7l_armhf.deb?raw=1) | [cinc-16.2.44-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/1jqqk19bazvakhg/cinc-16.2.44-1.el7.armv7hl.rpm?raw=1) | [cinc-16.2.44-1.el7.armv7hl.rpm](https://www.dropbox.com/s/dxim6vjxoug831z/cinc-16.2.44-rpi-armv6l_armhf.deb?raw=1) |
| Chef Infra 16.1.16 | [chef-16.1.16-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/3aixsqnkj4rxmyz/chef-16.1.16-rpi-armv6l_armhf.deb?raw=1) | [chef-16.1.16-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/gq94ktkg9mto53e/chef-16.1.16-rpi3-armv7l_armhf.deb?raw=1) | [chef-16.1.16-1.el7.armv7hl.rpm](https://www.dropbox.com/s/l07cv664qabplll/chef-16.1.16-1.el7.armv7hl.rpm?raw=1) |
| Cinc 16.1.16 | [cinc-16.1.16-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/j8jg0k7fizmzx31/cinc-16.1.17-rpi-armv6l_armhf.deb?raw=1) | [cinc-16.1.16-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/jkwtqf7l28rf089/cinc-16.1.16-rpi3-armv7l_armhf.deb?raw=1) | [cinc-16.1.16-1.el7.armv7hl.rpm](https://www.dropbox.com/s/93r5nomxbx6ywgl/cinc-16.1.16-1.el7.armv7hl.rpm?raw=1) |

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

in an attempt to support both the 6l and 7l ARMHF platforms. This breaks the Chef 32-bit ARM builds on Raspbian so I have replaced this line with

    echo /usr/lib/arm-linux-gnueabihf/libarmmem-v7l.so > /etc/ld.so.preload

on the Raspberry Pi 3 and 4 and

    echo /usr/lib/arm-linux-gnueabihf/libarmmem-v6l.so > /etc/ld.so.preload

on the Raspberry Pi Zero.

## Omnibus User

Add the `omnibus` user for performing the builds.

    adduser omnibus

Ensure the `omnibus` user has `sudo` privileges and add the following file to `/etc/sudoers.d/omnibus`. Feel free to use the `wheel` group or more limited permissions as necessary.

    omnibus  ALL=(ALL)       NOPASSWD: ALL

You can now `sudo su - omnibus` and continue without changing users. The `omnibus` user is used with the

# Scripts

If you want detailed instructions for building on these platforms check out [Chef 15 Build Instructions for 32-bit ARM](/2019/05/18/chef-15-on-arm). The build is currently Ruby 2.6.6 and does not require any additional patches. If you want to make your own builds, these are the scripts that were used:

| Version | DEB Build Script | RPM Build Script |
|:-|:-|:-|
| Chef Infra/Cinc 16.2.44 | [DEB-chef-cinc-16.2.44.sh](/assets/DEB-chef-cinc-16.2.44.sh) | [RPM-chef-cinc-16.2.44.sh](/assets/RPM-chef-cinc-16.2.44.sh) |
| Chef Infra/Cinc 16.1.16 | [DEB-chef-cinc-16.1.16.sh](/assets/DEB-chef-cinc-16.1.16.sh) | [RPM-chef-cinc-16.1.16.sh](/assets/RPM-chef-cinc-16.1.16.sh) |

# Additional Notes

## GPU Memory Usage

Because my systems are used primarily has headless servers, I've configured them to use less GPU memory by setting

    gpu_mem=16

in the `/boot/config.txt`. I do this in the [mattray::raspberrypi](https://github.com/mattray/mattray-cookbook/blob/master/recipes/raspberrypi.rb#L59) recipe used by all of my Raspbian systems.

## Chef LEDs Handler Cookbook

If you're using these builds you might be interested in the LEDs Handler cookbook. At the beginning of the Chef client run the LEDs blink a heartbeat pattern and at the end of the client run the LEDs are disabled. If the Chef client run fails the LEDs all stay on. It's pretty simple but it's a fun notification that the nodes are converging. It also works with Mac laptops running Linux, lighting up their keyboards when the Chef client is active.

<a href="https://github.com/mattray/leds_handler-cookbook"><img src="/assets/flashing_leds.gif" alt="Flashing LEDs" width="213" height="120" align="right" /></a>

[https://github.com/mattray/leds_handler-cookbook](https://github.com/mattray/leds_handler-cookbook)
