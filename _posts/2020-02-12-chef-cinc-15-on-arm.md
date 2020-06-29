---
title: Chef and Cinc Infra Client 15.8.23 Builds for CentOS, Debian and Raspbian on 32-bit ARM
---

UPDATE: The latest builds and instructions are now at the [32-bit Arm Chef Infra and Cinc Client Builds for Linux](/arm/) landing page.

<a href="https://github.com/chef/chef"><img src="/assets/chef-logo.png" alt="Chef" width="100" height="100" align="left" /></a>
<a href="https://gitlab.com/cinc-project/client"><img src="/assets/cinc-logo.png" alt="Cinc" width="100" height="100" align="right" /></a>

There's a new [Chef Infra Client 15.8.23]() build and it's time for new 32-bit ARM builds. I'm now providing [Cinc](https://cinc.sh) community builds of the same versions considering these are all technically "unsupported" builds either way. All previous patches have been upstreamed, so these build right off of the master branch.

The Cinc build is a [series of patches](https://gitlab.com/cinc-project/client/blob/master/patch.sh) applied on top of the Chef code. I've [slightly modified the patch](https://github.com/mattray/mattray.github.io/blob/a23e23938a592321916592e482a8a1eaea0f70f3/assets/DEB-chef-cinc-15.7.32.sh#L80) for my builds to not check out the code again, just to patch the code from the download version of the Chef code and not cache things for future builds. These build scripts build and install Ruby, the latest [omnibus-toolchain](https://github.com/chef/omnibus-toolchain), download and build Chef, get the Cinc patches and apply them to a clean copy of the same Chef code base and then build that. You can edit the script to disable Chef or Cinc depending on your preference if you don't want one of them.

# Build Instructions

If you want full instructions explained, here they are:

- [Chef 15 for 32-bit ARM](/2019/05/18/chef-15-on-arm)

**Please note the [ld.so.preload](/2019/09/14/installing-raspbian-10-0-on-a-raspberry-pi) instructions for Raspbian 10.** Here are the updated single scripts to do a full build as the `omnibus` user:

Chef Infra 15.8.23
- CentOS: [RPM-chef-cinc-15.8.23.sh](/assets/RPM-chef-cinc-15.8.23.sh) and run `nohup bash RPM-chef-cinc-15.8.23.sh &`
- Debian/Raspbian/Ubuntu: [DEB-chef-cinc-15.8.23.sh](/assets/DEB-chef-cinc-15.8.23.sh) and run  `nohup bash DEB-chef-cinc-15.8.23.sh &`

And `tail -f nohup.out` the output. The Raspberry Pi Zero is extremely slow to build, you may need to `renice` the build processes to keep it from dying.

# Chef Infra Client 15.8.23 32-bit ARM DEB and RPM Packages

- The 32-bit CentOS ARMv7hl package (Raspberry Pi 3 (A, A+, B+)):
  - [chef-15.8.23-1.el7.armv7hl.rpm](https://www.dropbox.com/s/xnumtt3y2zsw0e7/chef-15.8.23-1.el7.armv7hl.rpm?raw=1)

- The 32-bit Raspbian ARMv6l packages (Raspberry Pi 1/0 series):
  - [chef-15.8.23-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/q87t6qex4c32jx5/chef-15.8.23-rpi-armv6l_armhf.deb?raw=1)

- The 32-bit Debian/Raspbian/Ubuntu ARMv7l package (Raspberry Pi 3/4 series (Raspberry Pi 2 is untested but should work):
  - [chef-15.8.23-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/zyywlp6a6lq0w7a/chef-15.8.23-rpi3-armv7l_armhf.deb?raw=1)

# Cinc Infra Client 15.8.23 32-bit ARM DEB and RPM Packages

- The 32-bit CentOS ARMv7hl package (Raspberry Pi 3 (A, A+, B+)):
  - [cinc-15.8.23-1.el7.armv7hl.rpm](https://www.dropbox.com/s/vm4up4v01rfhmhr/cinc-15.8.23-1.el7.armv7hl.rpm?raw=1)

- The 32-bit Raspbian ARMv6l packages (Raspberry Pi 1/0 series):
  - [cinc-15.8.23-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/whd2ouxya1t9kv6/cinc-15.8.23-rpi-armv6l_armhf.deb?raw=1)

- The 32-bit Debian/Raspbian/Ubuntu ARMv7l package (Raspberry Pi 3/4 series (Raspberry Pi 2 is untested but should work):
  - [cinc-15.8.23-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/l9pl9jdb1rogo7j/cinc-15.8.23-rpi3-armv7l_armhf.deb?raw=1)

# Chef LEDs Handler Cookbook

<a href="https://github.com/mattray/leds_handler-cookbook"><img src="/assets/flashing_leds.gif" alt="Flashing LEDs" width="213" height="120" align="left" /></a>&nbsp;&nbsp;&nbsp;&nbsp;

If you're using these builds you might be interested in the LEDs Handler cookbook. At the beginning of the Chef client run the LEDs blink a heartbeat pattern and at the end of the client run the LEDs are disabled. If the Chef client run fails the LEDs all stay on. It's pretty simple but it's a fun notification that the nodes are converging. It also works with Mac laptops running Linux, lighting up their keyboards when the Chef client is active.

[https://github.com/mattray/leds_handler-cookbook](https://github.com/mattray/leds_handler-cookbook)
