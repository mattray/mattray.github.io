---
layout: default
title: 32-bit ARM Chef Infra and Cinc Client Builds for Linux
permalink: /arm/
---

I've been doing builds of Chef and Cinc for 32-bit ARM systems (Raspberry Pi and similar) for awhile, so I figured I'd create a landing page for them.

# Configuration and Build

If you want detailed instructions for installation and/or building on these platforms:

- [Installing/Configuring Raspbian on a Raspberry Pi Zero/3/4](/2019-09-14-installing-raspbian-10-0-on-a-raspberry-pi.CD)
- [Chef 15 Build Instructions for 32-bit ARM](/2019/05/18/chef-15-on-arm)

# Builds

The 32-bit ARM build targets are Debian/Raspbian/Ubuntu on the ARMv6l (Raspberry Pi 1/Zero series) and ARMv7hl (Raspberry Pi 2/3/4 series). CentOS 7 RPMs are also provided for the ARMv7hl.

| Version | ARMv6l DEB | ARMv7l DEB | ARMv7l RPM |
|:-|:-|:-|:-|
| Chef Infra 16.1.16 | [chef-16.1.16-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/3aixsqnkj4rxmyz/chef-16.1.16-rpi-armv6l_armhf.deb?raw=1) | [chef-16.1.16-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/gq94ktkg9mto53e/chef-16.1.16-rpi3-armv7l_armhf.deb?raw=1) | [chef-16.1.16-1.el7.armv7hl.rpm](https://www.dropbox.com/s/l07cv664qabplll/chef-16.1.16-1.el7.armv7hl.rpm?raw=1) |
| Cinc 16.1.16 | [cinc-16.1.16-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/j8jg0k7fizmzx31/cinc-16.1.17-rpi-armv6l_armhf.deb?raw=1) | [cinc-16.1.16-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/jkwtqf7l28rf089/cinc-16.1.16-rpi3-armv7l_armhf.deb?raw=1) | [cinc-16.1.16-1.el7.armv7hl.rpm](https://www.dropbox.com/s/93r5nomxbx6ywgl/cinc-16.1.16-1.el7.armv7hl.rpm?raw=1) |

# Scripts

If you want to make your own builds, these are the scripts that were used:

| Version | DEB Build Script | RPM Build Script |
|:-|:-|:-|
| Chef Infra/Cinc 16.1.16 | [DEB-chef-cinc-16.1.16.sh](/assets/DEB-chef-cinc-16.1.16.sh) | [RPM-chef-cinc-16.1.16.sh](/assets/RPM-chef-cinc-16.1.16.sh) |

# Chef LEDs Handler Cookbook

If you're using these builds you might be interested in the LEDs Handler cookbook. At the beginning of the Chef client run the LEDs blink a heartbeat pattern and at the end of the client run the LEDs are disabled. If the Chef client run fails the LEDs all stay on. It's pretty simple but it's a fun notification that the nodes are converging. It also works with Mac laptops running Linux, lighting up their keyboards when the Chef client is active.

<a href="https://github.com/mattray/leds_handler-cookbook"><img src="/assets/flashing_leds.gif" alt="Flashing LEDs" width="213" height="120" align="right" /></a>

[https://github.com/mattray/leds_handler-cookbook](https://github.com/mattray/leds_handler-cookbook)
