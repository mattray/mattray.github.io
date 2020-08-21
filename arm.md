---
layout: default
title: 32-bit Arm Chef Infra and Cinc Client Builds for Linux
permalink: /arm/
---

I've been doing builds of Chef and Cinc for 32-bit Arm systems (Raspberry Pi and similar) for awhile, so I figured I'd create a landing page for them. You may download the builds I've made or follow the instructions to make your own.


# Available Builds

The 32-bit Arm build targets are Debian/Raspbian/Ubuntu on the `armv6l` (Raspberry Pi 1/Zero series) and `armv7hl` (Raspberry Pi 2/3/4 series). CentOS 7 RPMs are also provided for the `armv7hl`.

| Version | armv6l DEB | armv7l DEB | armv7l RPM |
|:-|:-|:-|:-|
| **Chef Infra 16.4.41** | [chef-16.4.41-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/qcbgno6i5wqg334/chef-16.4.41-rpi-armv6l_armhf.deb?raw=1) | [chef-16.4.41-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/ellxp89xy4p0wyl/chef-16.4.41-rpi3-armv7l_armhf.deb?raw=1) | [chef-16.4.41-1.el7.armv7hl.rpm](https://www.dropbox.com/s/5wmy0fpnhsvxnsu/chef-16.4.41-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 16.3.45** | [chef-16.3.45-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/hj4u8963ybojyjy/chef-16.3.45-rpi-armv6l_armhf.deb?raw=1) | [chef-16.3.45-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/wp055b8ubco2qg7/chef-16.3.45-rpi3-armv7l_armhf.deb?raw=1) | [chef-16.3.45-1.el7.armv7hl.rpm](https://www.dropbox.com/s/ub6a0t6l28c1rk5/chef-16.3.45-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 16.3.38** | [chef-16.3.38-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/h524o4dekesdns9/chef-16.3.38-rpi-armv6l_armhf.deb?raw=1) | [chef-16.3.38-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/qpfevou47jefxsx/chef-16.3.38-rpi3-armv7l_armhf.deb?raw=1) | [chef-16.3.38-1.el7.armv7hl.rpm](https://www.dropbox.com/s/psvvkzxqk8yandz/chef-16.3.38-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 16.2.73** | [chef-16.2.73-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/o6asjsti346vnxm/chef-16.2.73-rpi-armv6l_armhf.deb?raw=1) | [chef-16.2.73-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/hw1kui7l79b2jvr/chef-16.2.73-rpi3-armv7l_armhf.deb?raw=1) | [chef-16.2.73-1.el7.armv7hl.rpm](https://www.dropbox.com/s/td700y8bnymjav3/chef-16.2.73-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 16.2.50** | [chef-16.2.50-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/wohq7hmr4sbahw6/chef-16.2.50-rpi-armv6l_armhf.deb?raw=1) | [chef-16.2.50-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/fcnzko122ne8cq9/chef-16.2.50-rpi3-armv7l_armhf.deb?raw=1) | [chef-16.2.50-1.el7.armv7hl.rpm](https://www.dropbox.com/s/duhfem86gwrvx7r/chef-16.2.50-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 16.2.44** | [chef-16.2.44-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/b8rmvu2t7u813vr/chef-16.2.44-rpi-armv6l_armhf.deb?raw=1) | [chef-16.2.44-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/qghjhnd2ei7ibkp/chef-16.2.44-rpi3-armv7l_armhf.deb?raw=1) | [chef-16.2.44-1.el7.armv7hl.rpm](https://www.dropbox.com/s/v7znbxlkzzcwbj9/chef-16.2.44-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 16.1.16** | [chef-16.1.16-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/3aixsqnkj4rxmyz/chef-16.1.16-rpi-armv6l_armhf.deb?raw=1) | [chef-16.1.16-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/gq94ktkg9mto53e/chef-16.1.16-rpi3-armv7l_armhf.deb?raw=1) | [chef-16.1.16-1.el7.armv7hl.rpm](https://www.dropbox.com/s/l07cv664qabplll/chef-16.1.16-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 16.1.0** | [chef-16.1.0-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/8jkxek8jaw0o9en/chef-16.1.0-rpi-armv6l_armhf.deb?raw=1) | [chef-16.1.0-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/5gqss0m6ezkwho0/chef-16.1.0-rpi3-armv7l_armhf.deb?raw=1) | [chef-16.1.0-1.el7.armv7hl.rpm](https://www.dropbox.com/s/cdmxs3v26qx45og/chef-16.1.0-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 16.0.287** | [chef-16.0.287-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/2l0u6b9oz2oy74j/chef-16.0.287-rpi-armv6l_armhf.deb?raw=1) | [chef-16.0.287-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/q6c7gqjs3ipclu1/chef-16.0.287-rpi3-armv7l_armhf.deb?raw=1) | [chef-16.0.287-1.el7.armv7hl.rpm](https://www.dropbox.com/s/7y3x14jwbdq2akt/chef-16.0.287-1.el7.armv7hl.rpm?raw=1)|
| **Chef Infra 16.0.275** | [chef-16.0.275-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/bg0h3u2tbnfexti/chef-16.0.275-rpi-armv6l_armhf.deb?raw=1) | [chef-16.0.275-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/mn16cf8mpph0sas/chef-16.0.275-rpi3-armv7l_armhf.deb?raw=1) | [chef-16.0.275-1.el7.armv7hl.rpm](https://www.dropbox.com/s/1cqkbrhyy14wcvh/chef-16.0.275-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 16.0.257** | [chef-16.0.257-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/64fwmciciie8smr/chef-16.0.257-rpi-armv6l_armhf.deb?raw=1) | [chef-16.0.257-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/9iocus2yb0vj7e6/chef-16.0.257-rpi3-armv7l_armhf.deb?raw=1) | [chef-16.0.257-1.el7.armv7hl.rpm](https://www.dropbox.com/s/ebqldrl34rxim4n/chef-16.0.257-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 15.13.8** | [chef-15.13.8-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/42y21qxjui95psi/chef-15.13.8-rpi-armv6l_armhf.deb?raw=1) | [chef-15.13.8-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/5z0wnlz3hl6eubz/chef-15.13.8-rpi3-armv7l_armhf.deb?raw=1) | [chef-15.13.8-1.el7.armv7hl.rpm](https://www.dropbox.com/s/fj4nv7mijf8bjic/chef-15.13.8-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 15.12.22** | | [chef-15.12.22-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/8txyrpv4rmyrvcb/chef-15.12.22-rpi3-armv7l_armhf.deb?raw=1) | [chef-15.12.22-1.el7.armv7hl.rpm](https://www.dropbox.com/s/dexzj3ti1tfm9hw/chef-15.12.22-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 15.11.3** | [chef-15.11.3-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/tmr693jhi6z12y6/chef-15.11.3-rpi-armv6l_armhf.deb?raw=1) | [chef-15.11.3-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/w3s9pf9elileppr/chef-15.11.3-rpi3-armv7l_armhf.deb?raw=1) | [chef-15.11.3-1.el7.armv7hl.rpm](https://www.dropbox.com/s/grygu7r60cnu0u5/chef-15.11.3-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 15.10.12** | [chef-15.10.12-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/b4lsmb3wu6gzf1g/chef-15.10.12-rpi-armv6l_armhf.deb?raw=1) | [chef-15.10.12-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/pyfg38aqrkcrc28/chef-15.10.12-rpi3-armv7l_armhf.deb?raw=1) | [chef-15.10.12-1.el7.armv7hl.rpm](https://www.dropbox.com/s/u3gwn400f6ya2i3/chef-15.10.12-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 15.9.17** | [chef-15.9.17-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/rxkpo4p9o5iefn5/chef-15.9.17-rpi-armv6l_armhf.deb?raw=1) | [chef-15.9.17-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/8l90jvbnwl6gbku/chef-15.9.17-1.el7.armv7hl.rpm?raw=1) | [chef-15.9.17-1.el7.armv7hl.rpm](https://www.dropbox.com/s/8l90jvbnwl6gbku/chef-15.9.17-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 15.8.23** | [chef-15.8.23-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/q87t6qex4c32jx5/chef-15.8.23-rpi-armv6l_armhf.deb?raw=1) | [chef-15.8.23-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/zyywlp6a6lq0w7a/chef-15.8.23-rpi3-armv7l_armhf.deb?raw=1) | [chef-15.8.23-1.el7.armv7hl.rpm](https://www.dropbox.com/s/xnumtt3y2zsw0e7/chef-15.8.23-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 15.7.32** | [chef-15.7.32-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/88irjgd94xvtz30/chef-15.7.32-rpi-armv6l_armhf.deb?raw=1) | [chef-15.7.32-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/4tpptidvhqvqzog/chef-15.7.32-rpi3-armv7l_armhf.deb?raw=1) | [chef-15.7.32-1.el7.armv7hl.rpm](https://www.dropbox.com/s/vum4agzwu6solhm/chef-15.7.32-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 15.6.10** | [chef-15.6.10-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/q9jqy3dl82tb6pu/chef-15.6.10-rpi-armv6l_armhf.deb?raw=1) | [chef-15.6.10-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/g3hhoo375uk8dqf/chef-15.6.10-rpi3-armv7l_armhf.deb?raw=1) | [chef-15.6.10-1.el7.armv7hl.rpm](https://www.dropbox.com/s/ipox8yvncx3eamm/chef-15.6.10-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 15.5.15** | [chef-15.5.15-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/1ho32cptw5texvg/chef-15.5.15-rpi-armv6l_armhf.deb?raw=1) | [chef-15.5.15-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/9gl23z2aeqtngmh/chef-15.5.15-rpi3-armv7l_armhf.deb?raw=1) | [chef-15.5.15-1.el7.armv7hl.rpm](https://www.dropbox.com/s/bcelkt4hbaz16k2/chef-15.5.15-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 15.4.45** | [chef-15.4.45-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/6kdg7xdpqizlv6p/chef-15.4.45-1.el7.armv7hl.rpm?raw=1) | [chef-15.4.45-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/x1bj31ro4ji2gui/chef-15.4.45-rpi3-armv7l_armhf.deb?raw=1) | [chef-15.4.45-1.el7.armv7hl.rpm](https://www.dropbox.com/s/6kdg7xdpqizlv6p/chef-15.4.45-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 15.3.14** | [chef-15.3.14-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/h5g3irg5m58z9hi/chef-15.3.14-rpi-armv6l_armhf.deb?raw=1) | [chef-15.3.14-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/yz2s3ij95jteqwg/chef-15.3.14-rpi3-armv7l_armhf.deb?raw=1) | [chef-15.3.14-1.el7.armv7hl.rpm](https://www.dropbox.com/s/cpi41gl7gvgeuby/chef-15.3.14-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 15.1.36** | [chef-15.1.36-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/h5g3irg5m58z9hi/chef-15.1.36-rpi-armv6l_armhf.deb?raw=1) | [chef-15.1.36-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/yz2s3ij95jteqwg/chef-15.1.36-rpi3-armv7l_armhf.deb?raw=1) | [chef-15.1.36-1.el7.armv7hl.rpm](https://www.dropbox.com/s/cpi41gl7gvgeuby/chef-15.1.36-1.el7.armv7hl.rpm?raw=1) |
| **Chef Infra 15.0.300** | [chef-15.0.300-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/7unouanbm6uo6ge/chef-15.0.300-rpi-armv6l_armhf.deb?raw=1) | [chef-15.0.300-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/rjtr2guibg5xv16/chef-15.0.300-rpi3-armv7l_armhf.deb?raw=1) | [chef-15.0.300-1.el7.armv7hl.rpm](https://www.dropbox.com/s/5ps0f2uni7ifb7w/chef-15.0.300-1.el7.armv7hl.rpm?raw=1) |
| **Cinc 16.4.41** | [cinc-16.4.41-rpi-armv6l_armhf.deb]() | [cinc-16.4.41-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/hgmgcwj4cqxir2j/cinc-16.4.41-rpi3-armv7l_armhf.deb?raw=1) | [cinc-16.4.41-1.el7.armv7hl.rpm](https://www.dropbox.com/s/2aelf9nhgmbmmiq/cinc-16.4.41-1.el7.armv7hl.rpm?raw=1) |
| **Cinc 16.3.47** | [cinc-16.3.47-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/u9jnbz4foeiqqrt/cinc-16.3.47-rpi-armv6l_armhf.deb?raw=1) | [cinc-16.3.47-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/z3iahy66f0uua9b/cinc-16.3.47-rpi3-armv7l_armhf.deb?raw=1) | [cinc-16.3.47-1.el7.armv7hl.rpm](https://www.dropbox.com/s/u9jnbz4foeiqqrt/cinc-16.3.47-rpi-armv6l_armhf.deb?raw=1) |
| **Cinc 16.3.38** | [cinc-16.3.38-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/j6sdezttf3bq0t0/cinc-16.3.38-rpi-armv6l_armhf.deb?raw=1) | [cinc-16.3.38-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/l66k8oyy9z1oj2h/cinc-16.3.38-rpi3-armv7l_armhf.deb?raw=1) | [cinc-16.3.38-1.el7.armv7hl.rpm](https://www.dropbox.com/s/5lcgz5wmwsahzup/cinc-16.3.38-1.el7.armv7hl.rpm?raw=1) |
| **Cinc 16.2.73** | [cinc-16.2.73-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/6buhziat76pi0t8/cinc-16.2.73-rpi-armv6l_armhf.deb?raw=1) | [cinc-16.2.73-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/hxhrlo3glrl6sep/cinc-16.2.73-rpi3-armv7l_armhf.deb?raw=1) | [cinc-16.2.73-1.el7.armv7hl.rpm](https://www.dropbox.com/s/uhv2azzzbdurg4g/cinc-16.2.73-1.el7.armv7hl.rpm?raw=1) |
| **Cinc 16.2.52** | [cinc-16.2.52-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/ho8kvfgmszzcy5f/cinc-16.2.52-rpi-armv6l_armhf.deb?raw=1) | [cinc-16.2.52-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/bs250xo6tutwybj/cinc-16.2.52-rpi3-armv7l_armhf.deb?raw=1) | [cinc-16.2.52-1.el7.armv7hl.rpm](https://www.dropbox.com/s/rx9tqbeims1utcz/cinc-16.2.52-1.el7.armv7hl.rpm?raw=1) |
| **Cinc 16.2.44** | [cinc-16.2.44-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/wwth6b56l282t8w/cinc-16.2.44-rpi3-armv7l_armhf.deb?raw=1) | [cinc-16.2.44-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/1jqqk19bazvakhg/cinc-16.2.44-1.el7.armv7hl.rpm?raw=1) | [cinc-16.2.44-1.el7.armv7hl.rpm](https://www.dropbox.com/s/dxim6vjxoug831z/cinc-16.2.44-rpi-armv6l_armhf.deb?raw=1) |
| **Cinc 16.1.16** | [cinc-16.1.16-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/j8jg0k7fizmzx31/cinc-16.1.17-rpi-armv6l_armhf.deb?raw=1) | [cinc-16.1.16-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/jkwtqf7l28rf089/cinc-16.1.16-rpi3-armv7l_armhf.deb?raw=1) | [cinc-16.1.16-1.el7.armv7hl.rpm](https://www.dropbox.com/s/93r5nomxbx6ywgl/cinc-16.1.16-1.el7.armv7hl.rpm?raw=1) |
| **Cinc 16.1.0** | [cinc-16.1.0-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/bfvaagthxb9bmpe/cinc-16.1.0-rpi-armv6l_armhf.deb?raw=1) | [cinc-16.1.0-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/uufgkd9fo06zccs/cinc-16.1.0-rpi3-armv7l_armhf.deb?raw=1) | [cinc-16.1.0-1.el7.armv7hl.rpm](https://www.dropbox.com/s/ypm4cil3zlk0why/cinc-16.1.0-1.el7.armv7hl.rpm?raw=1) |
| **Cinc 16.0.287** | [cinc-16.0.287-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/4c2u4dyexcpce5m/cinc-16.0.287-rpi-armv6l_armhf.deb?raw=1) | [cinc-16.0.287-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/brmt01j4h096oi3/cinc-16.0.287-rpi3-armv7l_armhf.deb?raw=1) | [cinc-16.0.287-1.el7.armv7hl.rpm](https://www.dropbox.com/s/b4b5hzktty1aslg/cinc-16.0.287-1.el7.armv7hl.rpm?raw=1) |
| **Cinc 16.0.275** | [cinc-16.0.275-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/u67ocgk8z9qpmxx/cinc-16.0.275-rpi-armv6l_armhf.deb?raw=1) | [cinc-16.0.275-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/q6mq6uu2l4u7uid/cinc-16.0.275-rpi3-armv7l_armhf.deb?raw=1) | [cinc-16.0.275-1.el7.armv7hl.rpm](https://www.dropbox.com/s/lydwnzvxhr7d18a/cinc-16.0.275-1.el7.armv7hl.rpm?raw=1) |
| **Cinc 16.0.258** | [cinc-16.0.258-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/pn90730z5ahqxlh/cinc-16.0.258-rpi-armv6l_armhf.deb?raw=1) | [cinc-16.0.258-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/cowq1snna36qj08/cinc-16.0.258-rpi3-armv7l_armhf.deb?raw=1) | [cinc-16.0.258-1.el7.armv7hl.rpm](https://www.dropbox.com/s/keohaw7baazqy5n/cinc-16.0.258-1.el7.armv7hl.rpm?raw=1) |
| **Cinc 15.10.14** | [cinc-15.10.14-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/4du2cm21hx80655/cinc-15.10.14-rpi-armv6l_armhf.deb?raw=1) | [cinc-15.10.14-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/eqiv1aqe6gixvl1/cinc-15.10.14-rpi3-armv7l_armhf.deb?raw=1) | [cinc-15.10.14-1.el7.armv7hl.rpm](https://www.dropbox.com/s/li5izo05vbmd3e5/cinc-15.10.14-1.el7.armv7hl.rpm?raw=1) |
| **Cinc 15.9.17** | [cinc-15.9.17-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/ck9oilua8mvo8hr/cinc-15.9.17-rpi-armv6l_armhf.deb?raw=1) | [cinc-15.9.17-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/km7xjgau2uxn3hk/cinc-15.9.17-rpi3-armv7l_armhf.deb?raw=1) | [cinc-15.9.17-1.el7.armv7hl.rpm](https://www.dropbox.com/s/8l90jvbnwl6gbku/chef-15.9.17-1.el7.armv7hl.rpm?raw=1) |
| **Cinc 15.8.23** | [cinc-15.8.23-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/whd2ouxya1t9kv6/cinc-15.8.23-rpi-armv6l_armhf.deb?raw=1) | [cinc-15.8.23-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/l9pl9jdb1rogo7j/cinc-15.8.23-rpi3-armv7l_armhf.deb?raw=1) | [cinc-15.8.23-1.el7.armv7hl.rpm](https://www.dropbox.com/s/vm4up4v01rfhmhr/cinc-15.8.23-1.el7.armv7hl.rpm?raw=1) |
| **Cinc 15.7.32** | [cinc-15.7.32-rpi-armv6l_armhf.deb](https://www.dropbox.com/s/4hwhaek8potu4we/cinc-15.7.32-rpi-armv6l_armhf.deb?raw=1) | [cinc-15.7.32-rpi3-armv7l_armhf.deb](https://www.dropbox.com/s/l3pri2r53me10dr/cinc-15.7.32-rpi3-armv7l_armhf.deb?raw=1) | [cinc-15.7.32-1.el7.armv7hl.rpm](https://www.dropbox.com/s/9irk2ob6guc7zj0/cinc-15.7.32-1.el7.armv7hl.rpm?raw=1) |


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

If you want detailed instructions for the steps for building on these platforms check out [Chef 15 Build Instructions for 32-bit Arm](/2019/05/18/chef-15-on-arm). The build is currently Ruby 2.7.1 and does not require any additional patches. I typically run them as the `omnibus` user with something similar to `nohup bash RPM-chef-cinc-16.2.44.sh &` and `tail -f nohup.out` to monitor the output.

| Version | DEB Build Script | RPM Build Script |
|:-|:-|:-|
| **Chef Infra/Cinc 16.4.41** | [DEB-chef-cinc-16.4.41.sh](/assets/DEB-chef-cinc-16.4.41.sh) | [RPM-chef-cinc-16.4.41.sh](/assets/RPM-chef-cinc-16.4.41.sh) |
| **Chef Infra/Cinc 16.3.45** | [DEB-chef-cinc-16.3.45.sh](/assets/DEB-chef-cinc-16.3.45.sh) | [RPM-chef-cinc-16.3.45.sh](/assets/RPM-chef-cinc-16.3.45.sh) |
| **Chef Infra/Cinc 16.3.38** | [DEB-chef-cinc-16.3.38.sh](/assets/DEB-chef-cinc-16.3.38.sh) | [RPM-chef-cinc-16.3.38.sh](/assets/RPM-chef-cinc-16.3.38.sh) |
| **Chef Infra/Cinc 16.2.73** | [DEB-chef-cinc-16.2.73.sh](/assets/DEB-chef-cinc-16.2.73.sh) | [RPM-chef-cinc-16.2.73.sh](/assets/RPM-chef-cinc-16.2.73.sh) |
| **Chef Infra/Cinc 16.2.50** | [DEB-chef-cinc-16.2.50.sh](/assets/DEB-chef-cinc-16.2.50.sh) | [RPM-chef-cinc-16.2.50.sh](/assets/RPM-chef-cinc-16.2.50.sh) |
| **Chef Infra/Cinc 16.2.44** | [DEB-chef-cinc-16.2.44.sh](/assets/DEB-chef-cinc-16.2.44.sh) | [RPM-chef-cinc-16.2.44.sh](/assets/RPM-chef-cinc-16.2.44.sh) |
| **Chef Infra/Cinc 16.1.16** | [DEB-chef-cinc-16.1.16.sh](/assets/DEB-chef-cinc-16.1.16.sh) | [RPM-chef-cinc-16.1.16.sh](/assets/RPM-chef-cinc-16.1.16.sh) |
| **Chef Infra/Cinc 16.1.0** | [DEB-chef-cinc-16.1.0.sh](/assets/DEB-chef-cinc-16.1.0.sh) | [RPM-chef-cinc-16.1.0.sh](/assets/RPM-chef-cinc-16.1.0.sh) |
| **Chef Infra/Cinc 16.0.287** | [DEB-chef-cinc-16.0.287.sh](/assets/DEB-chef-cinc-16.0.287.sh) | [RPM-chef-cinc-16.0.287.sh](/assets/RPM-chef-cinc-16.0.287.sh) |
| **Chef Infra/Cinc 16.0.275** | [DEB-chef-cinc-16.0.275.sh](/assets/DEB-chef-cinc-16.0.275.sh) | [RPM-chef-cinc-16.0.275.sh](/assets/RPM-chef-cinc-16.0.275.sh) |
| **Chef Infra/Cinc 16.0.257** | [DEB-chef-cinc-16.0.257.sh](/assets/DEB-chef-cinc-16.0.257.sh) | [RPM-chef-cinc-16.0.257.sh](/assets/RPM-chef-cinc-16.0.257.sh) |
| **Chef Infra 15.13.8** | [DEB-chef-15.13.8.sh](/assets/DEB-chef-15.13.8.sh) | [RPM-chef-15.13.8.sh](/assets/RPM-chef-15.13.8.sh) |
| **Chef Infra 15.12.22** | [DEB-chef-15.12.22.sh](/assets/DEB-chef-15.12.22.sh) | [RPM-chef-15.12.22.sh](/assets/RPM-chef-15.12.22.sh) |
| **Chef Infra 15.11.3** | [DEB-chef-15.11.3.sh](/assets/DEB-chef-15.11.3.sh) | [RPM-chef-15.11.3.sh](/assets/RPM-chef-15.11.3.sh) |
| **Chef Infra/Cinc 15.10.12** | [DEB-chef-cinc-15.10.12.sh](/assets/DEB-chef-cinc-15.10.12.sh) | [RPM-chef-cinc-15.10.12.sh](/assets/RPM-chef-cinc-15.10.12.sh) |
| **Chef Infra/Cinc 15.9.17** | [DEB-chef-cinc-15.9.17.sh](/assets/DEB-chef-cinc-15.9.17.sh) | [RPM-chef-cinc-15.9.17.sh](/assets/RPM-chef-cinc-15.9.17.sh) |
| **Chef Infra/Cinc 15.8.23** | [DEB-chef-cinc-15.8.23.sh](/assets/DEB-chef-cinc-15.8.23.sh) | [RPM-chef-cinc-15.8.23.sh](/assets/RPM-chef-cinc-15.8.23.sh) |
| **Chef Infra/Cinc 15.7.32** | [DEB-chef-cinc-15.7.32.sh](/assets/DEB-chef-cinc-15.7.32.sh) | [RPM-chef-cinc-15.7.32.sh](/assets/RPM-chef-cinc-15.7.32.sh) |
| **Chef Infra 15.6.10** | [DEB-chef-15.6.10.sh](/assets/DEB-chef-15.6.10.sh) | [RPM-chef-15.6.10.sh](/assets/RPM-chef-15.6.10.sh) |
| **Chef Infra 15.5.15** | [DEB-chef-15.5.15.sh](/assets/DEB-chef-15.5.15.sh) | [RPM-chef-15.5.15.sh](/assets/RPM-chef-15.5.15.sh) |
| **Chef Infra 15.3.14** | [DEB-chef-15.3.14.sh](/assets/chef-15.3.14-DEB.sh) | [RPM-chef-15.3.14.sh](/assets/chef-15.3.14-RPM.sh) |
| **Chef Infra 15.1.36** | [DEB-chef-15.1.36.sh](/assets/chef-15.1.36-DEB.sh) | [RPM-chef-15.1.36.sh](/assets/chef-15.1.36-RPM.sh) |
| **Chef Infra 15.0.300** | [DEB-chef-15.0.300.sh](/assets/chef-15.0.300-DEB.sh) | [RPM-chef-15.0.300.sh](/assets/chef-15.0.300-RPM.sh) |
| **Chef Infra/Cinc 14.15.6** | [DEB-chef-cinc-14.15.6.sh](/assets/DEB-chef-cinc-14.15.6.sh) | [RPM-chef-cinc-14.15.6.sh](/assets/RPM-chef-cinc-14.15.6.sh) |
| **Chef Infra 14.14.29** | [DEB-chef-14.14.29.sh](/assets/DEB-chef-14.14.29.sh) | [RPM-chef-14.14.29.sh](/assets/RPM-chef-14.14.29.sh) |
| **Chef Infra 14.14.25** | [DEB-chef-14.14.25.sh](/assets/DEB-chef-14.14.25.sh) | [RPM-chef-14.14.25.sh](/assets/RPM-chef-14.14.25.sh) |
| **Chef Infra 14.13.11** | [DEB-chef-14.13.11.sh](/assets/chef-14.13.11-DEB.sh) | [RPM-chef-14.13.11.sh](/assets/chef-14.13.11-RPM.sh) |


# Additional Notes

## GPU Memory Usage

Because my systems are used primarily has headless servers, I've configured them to use less GPU memory by setting

    gpu_mem=16

in the `/boot/config.txt`. I do this in the [mattray::raspberrypi](https://github.com/mattray/mattray-cookbook/blob/master/recipes/raspberrypi.rb#L59) recipe used by all of my Raspbian systems.

## Chef LEDs Handler Cookbook

If you're using these builds you might be interested in the LEDs Handler cookbook. At the beginning of the Chef client run the LEDs blink a heartbeat pattern and at the end of the client run the LEDs are disabled. If the Chef client run fails the LEDs all stay on. It's pretty simple but it's a fun notification that the nodes are converging. It also works with Mac laptops running Linux, lighting up their keyboards when the Chef client is active.

<a href="https://github.com/mattray/leds_handler-cookbook"><img src="/assets/flashing_leds.gif" alt="Flashing LEDs" width="213" height="120" align="right" /></a>

[https://github.com/mattray/leds_handler-cookbook](https://github.com/mattray/leds_handler-cookbook)
