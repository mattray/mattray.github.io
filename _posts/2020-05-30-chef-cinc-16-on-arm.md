---
title: Chef Infra and Cinc Client 16.1.16 Linux Builds for 32-bit ARM
---

<a href="https://github.com/chef/chef"><img src="/assets/chef-logo.png" alt="Chef" width="100" height="100" align="left" /></a>
<a href="https://gitlab.com/cinc-project/client"><img src="/assets/cinc-logo.png" alt="Cinc" width="100" height="100" align="right" /></a>

UPDATE: The latest builds and instructions are now at the [32-bit Arm Chef Infra and Cinc Client Builds for Linux](/arm/) landing page.

[Chef Infra Client 16.1.16](https://discourse.chef.io/t/chef-infra-client-16-1-16-released/17163) is available and here are new 32-bit ARM builds. I'm providing [Cinc](https://cinc.sh) community builds of the same versions considering these are all technically "unsupported" builds either way. There is a [small omnibus patch](https://github.com/chef/omnibus/pull/940) to use Ruby 2.7.1 for building against the master branch. This patch may not get upstreamed for awhile, switching back to Ruby 2.6.6 works fine too.

The Cinc build is a [series of patches](https://gitlab.com/cinc-project/client/blob/master/patch.sh) applied on top of the Chef code. I've [slightly modified the patch](https://github.com/mattray/mattray.github.io/blob/master/assets/DEB-chef-cinc-16.1.16.sh#L76) for my builds to reuse the omnibus-toolchain from the Chef build and patch the code from the download version of the Chef code and not cache things for future builds. These build scripts build and install Ruby, the latest [omnibus-toolchain](https://github.com/chef/omnibus-toolchain), download and build Chef, get the Cinc patches and apply them to a clean copy of the same Chef code base and then build that. You can edit the script to disable Chef or Cinc depending on your preference if you don't want one of them.

# Build Instructions

If you want full instructions explained, here they are:

- [Chef 15 for 32-bit ARM](/2019/05/18/chef-15-on-arm)

**Please note the [ld.so.preload](/2019/09/14/installing-raspbian-10-0-on-a-raspberry-pi) instructions for Raspbian 10.** Here are the updated single scripts to do a full build as the `omnibus` user:

Chef Infra 16.1.16
- CentOS: [RPM-chef-cinc-16.1.16.sh](/assets/RPM-chef-cinc-16.1.16.sh) and run `nohup bash RPM-chef-cinc-16.1.16.sh &`
- Debian/Raspbian/Ubuntu: [DEB-chef-cinc-16.1.16.sh](/assets/DEB-chef-cinc-16.1.16.sh) and run  `nohup bash DEB-chef-cinc-16.1.16.sh &`

And `tail -f nohup.out` to watch the output. The Raspberry Pi Zero is extremely slow to build, you may need to `renice` the build processes and enable swap to keep it from dying.

# Chef Infra Client 16.1.16 32-bit ARM DEB and RPM Packages

- The 32-bit CentOS ARMv7hl package (Raspberry Pi 3 (A, A+, B+)):
  - [chef-16.1.16-1.el7.armv7hl.rpm](https://www.dropbox.com/s/l07cv664qabplll/chef-16.1.16-1.el7.armv7hl.rpm?raw=1)


- The 32-bit Debian/Raspbian/Ubuntu ARMv6l packages (Raspberry Pi 1/0 series):
  - [chef-16.1.16-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/3aixsqnkj4rxmyz/chef-16.1.16-rpi-armv6l_armhf.deb?raw=1)

- The 32-bit Debian/Raspbian/Ubuntu ARMv7l package (Raspberry Pi 3/4 series (Raspberry Pi 2 is untested but should work):
  - [chef-16.1.16-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/gq94ktkg9mto53e/chef-16.1.16-rpi3-armv7l_armhf.deb?raw=1)

# Cinc Infra Client 16.1.16 32-bit ARM DEB and RPM Packages

- The 32-bit CentOS ARMv7hl package (Raspberry Pi 3 (A, A+, B+)):
  - [cinc-16.1.16-1.el7.armv7hl.rpm](https://www.dropbox.com/s/93r5nomxbx6ywgl/cinc-16.1.16-1.el7.armv7hl.rpm?raw=1)

- The 32-bit Debian/Raspbian/Ubuntu ARMv6l packages (Raspberry Pi 1/0 series):
  - [cinc-16.1.16-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/j8jg0k7fizmzx31/cinc-16.1.17-rpi-armv6l_armhf.deb?raw=1)

- The 32-bit Debian/Raspbian/Ubuntu ARMv7l package (Raspberry Pi 3/4 series (Raspberry Pi 2 is untested but should work):
  - [cinc-16.1.16-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/jkwtqf7l28rf089/cinc-16.1.16-rpi3-armv7l_armhf.deb?raw=1)

# Chef LEDs Handler Cookbook

<a href="https://github.com/mattray/leds_handler-cookbook"><img src="/assets/flashing_leds.gif" alt="Flashing LEDs" width="213" height="120" align="left" /></a>&nbsp;&nbsp;&nbsp;&nbsp;

If you're using these builds you might be interested in the LEDs Handler cookbook. At the beginning of the Chef client run the LEDs blink a heartbeat pattern and at the end of the client run the LEDs are disabled. If the Chef client run fails the LEDs all stay on. It's pretty simple but it's a fun notification that the nodes are converging. It also works with Mac laptops running Linux, lighting up their keyboards when the Chef client is active.

[https://github.com/mattray/leds_handler-cookbook](https://github.com/mattray/leds_handler-cookbook)
