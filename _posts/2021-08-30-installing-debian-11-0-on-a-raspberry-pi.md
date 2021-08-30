---
title: Installing Debian 11 on a Raspberry Pi Zero/3/4
---

## Getting Started

<a href="https://shop.pimoroni.com/products/raspberry-pi-zero-w"><img src="/assets/Pibow_Zero_ver_1.3_1_of_3_1024x1024.JPG" alt="Raspberry Pi Zero W" width="235" height="235" align="right" /></a>

In my home lab I have a several [Raspberry Pi 4](https://core-electronics.com.au/raspberry-pi-4-model-b-2gb.html), [Raspberry Pi 3 B+](https://core-electronics.com.au/raspberry-pi-3-model-b-plus.html), and [Raspberry Pi Zero W](https://shop.pimoroni.com/products/raspberry-pi-zero-w) devices. I primarily ran [Rasberry Pi OS Lite](https://www.raspberrypi.org/software/operating-systems/), but with the release of Debian 11 there are [official Raspberry Pi images](https://raspi.debian.net) available with for a minimal installation. Setting up and configuring these is pretty straightforward, but I thought I'd add my notes for easier reference. The instructions are fairly similar for each, so I'm going to focus on the Raspberry Pi 4.

## Installing the Base Image

I started with the [Tested Images](https://raspi.debian.net/tested-images/) and downloaded the proper xz-compressed image for each machine type.

I flashed the image onto a 32 gig microSD card with [Balena Etcher for OSX](https://www.etcher.io/).

With my microSD card ready I plugged in my micro-HDMI adapter and HDMI cable and a USB keyboard and booted into Debian.

## Configuring Debian

There are no non-root users, so you login as `root` with no password, which you'll want to immediately change with `passwd`.

So I could work on the machine from my laptop, I enabled remote root SSH access (disable this later).

    echo "PermitRootLogin yes" >> /etc/ssh/sshd_config

To set the hostname I ran:

    hostnamectl set-hostname larry.bottlebru.sh

The images come with wireless support, so it was simply a matter of adding the following to `/etc/network/interfaces.d/wlan0`

    allow-hotplug wlan0
    iface wlan0 inet dhcp
        wpa-ssid MYNETWORK
        wpa-psk MYPASSWORD

Unlike with Raspberry Pi OS, the images don't come with swap enabled, so no need to disable it. The partitions are also resized automatically, so there are no manual steps related to that either.

A quick reboot and I was able to SSH in as root remotely and administer the machine remotely.

### Managing with Cinc

The Raspberry Pi 3 & 4 are running `aarch64`, which is a supported platform from Cinc. I got the packages from http://downloads.cinc.sh/files/stable/cinc/17.4.38/debian/10/ and installed them

    apt install ./cinc-17.4.48-rpi-armv6l_armel.deb

I bootstrapped the boxes with my a [home boxes cookbook](https://github.com/mattray/mattray-cookbook) and policyfile from my [home-repo](https://github.com/mattray/home-repo/):

    knife bootstrap larry -N larry --policy-group home --policy-name base

Now it was ready to use.

The Raspberry Pi Zero identified as `armel` instead of the `armhf` that was used for the [Raspberry Pi OS builds](/arm/) I'd built previously, so I had to do a fresh build for the machines. Because I still have Raspberry Pi OS 10 applications running, I haven't upgraded these nodes yet.
