---
title: Installing Armbian 11 on a Pine64 ROCKPro64
---

## Getting Started

<a href="https://pine64.com/product/rockpro64-4gb-single-board-computer/"><img src="/assets/ROCKPro64-SBC-3.jpg" alt="Pine64 ROCKPro64" width="300" height="300" align="right" /></a>

The Pine64 ROCKPro64 is a fairly powerful 64-bit single board computer with a Rockchip RK3399 Hexa-Core (dual ARM Cortex A72 and quad ARM Cortex A53) processor and 4GB of RAM. I added it to my Arm devices homelab because it's a more powerful CPU than the [Raspberry Pi 4](https://core-electronics.com.au/raspberry-pi-4-model-b-2gb.html) but still priced at only $80 USD. I run [Armbian](https://www.armbian.com/rockpro64/) on it because I had some trouble getting the [official Debian 11](https://wiki.pine64.org/wiki/ROCKPro64_Software_Release#Debian) working, but they're really similar in the end.

## Installing the Base Image

I downloaded [Armbian's ROCKPro64](https://www.armbian.com/rockpro64/) image and flashed it onto a 32 gig microSD card with [Balena Etcher for macOS](https://www.etcher.io/).

With my microSD card ready I plugged in an HDMI cable to my monitor and a USB keyboard and booted into Armbian. From the console, I updated the `root` password with `passwd`, created a `mattray` user and set my timezone. I'm not using wifi with this box, so the network worked out of the box.

## Managing with Cinc

I installed the `aarch64` build , which is a supported platform from Cinc. I got the packages from http://downloads.cinc.sh/files/stable/cinc/17.9.52/debian/11/ and installed them

    apt install ./cinc_17.9.52-1_arm64.deb

I bootstrapped the boxes with my a [home boxes cookbook](https://github.com/mattray/mattray-cookbook) and policyfile from my [home-repo](https://github.com/mattray/home-repo/):

    knife bootstrap mom -N mom --policy-group home --policy-name base

This standardizes the machine with the same packages, users, and other settings. I tagged the machine with

    knife tag create mom cluster

To ensure that it picked up the `cluster` recipe which ensures all the members of the Kubernetes cluster have the right `/etc/hosts` entries and keep updated with the same version of Cinc.

## Post Install

The ROCKPro64 is typically the [K3s Server node](https://k3s.io) when I've been testing out Kubernetes deployments. It's the fastest of my Arm machines and just as easy to manage as any of the Raspberry Pi devices.
