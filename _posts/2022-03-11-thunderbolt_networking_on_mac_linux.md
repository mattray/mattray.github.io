---
title: Using Thunderbolt Networking under Linux on a Macbook Air
---

<a href="https://www.apple.com/au/shop/product/MD463ZM/A/thunderbolt-to-gigabit-ethernet-adapter"><img src="/assets/thunderbolt.jpg" alt="Apple Thunderbolt to Gigabit Ethernet Adapter" width="85" height="400" align="right" /></a>


I have several 2015 13" MacBook Airs in various states of disrepair that I run Debian on as part of my home testing cluster. Given they don't have ethernet ports, I've usually used USB network adapters because they are generally well-supported. One of my machines however, has a broken USB interface and I was unable to use this. I'd put it on a shelf to use for parts, but I found an Apple Thunderbolt to Gigabit Ethernet Adapter and figured I'd give that a whirl. Not surprisingly, Linux worked pretty seamlessly on 7+ year old technology.

After plugging it in, nothing happened. A bit of quick googling found that I needed the `thunderbolt` and `tg3` kernel modules, so I added them with:

```
modprobe tg3 thunderbolt
```

The device now showed up under `dmesg` and `lspci --nnk`

```
0a:00.0 Ethernet controller [0200]: Broadcom Inc. and subsidiaries NetXtreme BCM57762 Gigabit Ethernet PCIe [14e4:1682]
	Subsystem: Apple Inc. Thunderbolt to Gigabit Ethernet Adapter [106b:00f6]
	Kernel driver in use: tg3
	Kernel modules: tg3
```

But the network interface was not enabled according to `ip address`. I added the following to `/etc/network/interfaces`

```
# Thunderbolt
allow-hotplug ens9
iface ens9 inet dhcp
```

restarted my network and I was now connected via DHCP.

```
2: ens9: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc mq state UP group default qlen 1000
    link/ether 68:5b:35:9d:a5:25 brd ff:ff:ff:ff:ff:ff
    altname enp10s0
    inet 10.0.0.22/24 brd 10.0.0.255 scope global dynamic ens9
       valid_lft 84917sec preferred_lft 84917sec
    inet6 fe80::6a5b:35ff:fe9d:a525/64 scope link
       valid_lft forever preferred_lft forever
```

It works after rebooting and I now have another machine for my cluster (<a href="https://futurama.fandom.com/wiki/Yancy_Fry">"yancy"</a>).
