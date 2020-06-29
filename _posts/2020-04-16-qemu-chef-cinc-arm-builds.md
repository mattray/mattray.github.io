---
title: Notes on QEMU Builds of Chef Infra and Cinc Client for 32-bit ARM
---

<a href="https://github.com/chef/chef"><img src="/assets/chef-logo.png" alt="Chef" width="100" height="100" align="left" /></a>
<a href="https://gitlab.com/cinc-project/client"><img src="/assets/cinc-logo.png" alt="Cinc" width="100" height="100" align="right" /></a>

UPDATE: The latest builds and instructions are now at the [32-bit Arm Chef Infra and Cinc Client Builds for Linux](/arm/) landing page.

[QEMU](https://www.qemu.org/) is an open source machine emulator and virtualizer that allows you to run operating systems from different architectures. Traditional virtualization is running other operating systems with the same CPU architecture on that architecture (ie. x86 Windows on x86 Linux), but QEMU allows emulation of alternate architectures (ie. ARM or PowerPC) so you can run their operating systems and applications on different architectures.

Building the [Chef Infra and Cinc clients](https://mattray.github.io/2020/04/07/chef-cinc-15-on-arm.html) on [Raspberry Pi Zero](https://www.raspberrypi.org/products/raspberry-pi-zero-w/) devices may take up to 17 hours. The machine only has 512 megabytes of RAM, a slow ARMv6 32-bit processor, and it is running from an SD card. Faced with these limitations I decided to investigate emulating the 32-bit ARM platform on a 64-bit x86 machine.

# System Preparation

The first pass at building for the Raspberry Pi on x86 was inspired by Akkana Peck's post [Emulating Raspbian on your Linux x86/amd64 System](http://shallowsky.com/blog/linux/raspbian-virtual-on-x86.html). Rather than boot a complete operating system, I wanted to chroot into a target file system and let the QEMU CPU emulator intercept the calls. The build machine is Debian 10 x86_64 box with an Intel i7 870 2.93GHz CPU and 16 gigabytes of RAM with an SSD.

Commands run as root are prefixed with `#`

## Install QEMU

```
# apt install kpartx qemu binfmt-support qemu-user-static
```

# Preparing the Raspbian Operating System Image

I'm using the current Rasbian `Buster` Lite image [2020-02-05-raspbian-buster-lite.zip](https://www.raspberrypi.org/downloads/raspbian/). Unzip the downloaded image:
```
# unzip 2020-02-05-raspbian-buster-lite.zip
```

The default partitions in the image are too small for building software, so they'll need to be resized. First let's find the loop device associated with the image (you may have different results):
```
# losetup --find --show 2020-02-05-raspbian-buster-lite.img
/dev/loop0
```

Next we separate the partitions of the image into new images:
```
# parted -s 2020-02-05-raspbian-buster-lite.img unit KiB print
Model:  (file)
Disk /root/2020-02-05-raspbian-buster-lite.img: 1806336kiB
Sector size (logical/physical): 512B/512B
Partition Table: msdos
Disk Flags:

Number  Start      End         Size        Type     File system  Flags
 1      4096kiB    266240kiB   262144kiB   primary  fat32        lba
 2      266240kiB  1806336kiB  1540096kiB  primary  ext4
```

We'll use `dd` to extract the partitions into new images. Note that the `start` and `size` from `parted` map to the `skip` and `count` for the `dd` command:
```
# dd if=2020-02-05-raspbian-buster-lite.img of=Part1.img bs=1024 skip=4096 count=262144
262144+0 records in
262144+0 records out
268435456 bytes (268 MB, 256 MiB) copied, 0.776235 s, 346 MB/s
# dd if=2020-02-05-raspbian-buster-lite.img of=Part2.img bs=1024 skip=266240 count=1540096
1540096+0 records in
1540096+0 records out
1577058304 bytes (1.6 GB, 1.5 GiB) copied, 11.2463 s, 140 MB/s
```

These new images map to different loop devices, so let's find those mappings:
```
# losetup --find --show Part1.img
/dev/loop1
# losetup --find --show Part2.img
/dev/loop2
```

We need to make the root partition bigger, first we'll append 4 gigabytes to it:
```
# dd if=/dev/zero bs=1MiB of=/root/Part2.img conv=notrunc oflag=append count=4000
4000+0 records in
4000+0 records out
4194304000 bytes (4.2 GB, 3.9 GiB) copied, 7.24213 s, 579 MB/s
```

Next we'll resize the loop device and its filesystem:
```
# losetup -c /dev/loop2
# e2fsck -f /dev/loop2
e2fsck 1.44.5 (15-Dec-2018)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
rootfs: 44421/96384 files (0.3% non-contiguous), 291152/385024 blocks
# resize2fs /dev/loop2
resize2fs 1.44.5 (15-Dec-2018)
Resizing the filesystem on /dev/loop2 to 1409024 (4k) blocks.
The filesystem on /dev/loop2 is now 1409024 (4k) blocks long.
```

# Preparing the OS for Building

Now that the image has been prepared, we'll copy a few files to it to make it a suitable builder. The first step is to create a mount point and mount it.
```
# mkdir /mnt/pi_image
# mount /dev/loop2 /mnt/pi_image
# mount /dev/loop1 /mnt/pi_image/boot
```

Now we'll configure the machine with some specifics to building in my [home lab](https://github.com/mattray/home-repo). These are `sudo` support for the `omnibus` build account, configuring `/etc/hosts`, and supporting apt-cacher-ng.
```
# echo "omnibus  ALL=(ALL)       NOPASSWD: ALL" > /mnt/pi_image/etc/sudoers.d/omnibus
# sed -e 's/raspbian/crushinator/' /mnt/pi_image/etc/hosts > /mnt/pi_image/etc/hosts2
# mv /mnt/pi_image/etc/hosts2 /mnt/pi_image/etc/hosts
# echo "10.0.0.2       ndnd ndnd.bottlebru.sh" >> /mnt/pi_image/etc/hosts
# echo "Acquire::http::Proxy \"http://ndnd:3142\";" > /mnt/pi_image/etc/apt/apt.conf.d/01proxy
# echo "Acquire::https::Proxy \"https://ndnd:3142\";" >> /mnt/pi_image/etc/apt/apt.conf.d/01proxy
```

Raspbian sets the file /etc/ld.so.preload to `/usr/lib/arm-linux-gnueabihf/libarmmem-${PLATFORM}.so` in an attempt to support both the 6l and 7l ARMHF platforms. This breaks the Chef 32-bit ARM builds on Raspbian so I replaced this line with:
```
# echo /usr/lib/arm-linux-gnueabihf/libarmmem-v6l.so > //mnt/pi_image/etc/ld.so.preload
```

Because QEMU needs `/usr/bin/qemu-arm-static` to enable emulating ARM binaries in user mode, we'll copy it to the Raspbian filesystem so it will be available after the chroot:
```
# cp /usr/bin/qemu-arm-static /mnt/pi_image/usr/bin/
```

# Chrooting to Raspbian

Now that the QEMU mount point is configured, we can chroot into it

```
# chroot /mnt/pi_image /bin/bash
```

and we are now running in the emulated environment
```
# file /bin/ls
/bin/ls: ELF 32-bit LSB executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3, for GNU/Linux 3.2.0, BuildID[sha1]=67a394390830ea3ab4e83b5811c66fea9784ee69, stripped
```

# Building Chef & Cinc Clients

The operating system needs the latest patches and dependencies to get ready for building:
```
# apt update
# apt upgrade
# apt install -y autoconf build-essential fakeroot git libreadline-dev libssl-dev zlib1g-dev
```

We'll create the `omnibus` user and get the [Chef/Cinc 15.9.17 build script](/assets/DEB-chef-cinc-15.9.17.sh).
```
# adduser omnibus
# sudo su - omnibus
$ wget https://mattray.github.io/assets/DEB-chef-cinc-15.9.17.sh
```

Now we can finally kick off the build and watch the output.
```
$ nohup bash DEB-chef-cinc-15.9.17.sh &
$ tail -f nohup.out
```

# Build #1

That build successfully completed building Ruby 2.6.6 and the 3 .DEB packages for omnibus-software, Chef, and Cinc (Ruby only rebuilds for new releases). I benchmarked this head-to-head against the Raspberry Pi and here were the results:

```
QEMU Intel i7 870 2.93GHz CPU/16 gig RAM: 13:15
Native RPi Zero: 17:25
```

I copied the build to my Raspberry Pi Zero and it **failed**. Apparently the default for `qemu-arm-static` is `armv7l`. I copied the packages to a Raspberry Pi 3 and it worked just fine. Unfortunately 13 hours is much longer than the 3 it takes for a Raspberry Pi 4 to do these builds, so it's not saving me any time.

# Build #2

I looked into the QEMU documentation and searched until I stumbled across using environment variables such as `QEMU_CPU`. The Raspberry Pi Zero and 1 are `armv6l` and use the ARM1176 CPU. I exported that as the `QEMU_CPU` environment variable for our chroot (other ARM processor types could be emulated as well, `qemu-arm -cpu ?` for more choices). I rebuilt the build environment following the steps above and chrooted into the new image:

```
# export QEMU_CPU=arm1176
# chroot /mnt/pi_image /bin/bash
# uname -m
armv6l
```

I also noticed while reading the build logs that the `omnibus` commands were using `-j3`, so I increased the number of threads to take advantage of the 8 cores on the host machine by adding
```
--override workers:7
```

The build logs revealed that these were passed through and the benchmarks show that speed definitely improved:

```
QEMU Intel i7 870 2.93GHz CPU/16 gig RAM with -j 7: 10:20
Native RPi Zero: 17:25
```

Unfortunately despite successfully building packages, these [failed on the Raspberry Pi Zero](https://gist.github.com/mattray/3d40561b451945b4c9834573d5d00845) and didn't work on the Raspberry Pi 3 either.

# Build #3

After this failure I decided to embrace full QEMU virtualization. Unfortunately the recommended `armv6l` board `versatilepb` is limited to 256 megabytes of RAM and does not take advantage of the additional cores of the host operating system. I used the QEMU Raspberry Pi kernel from https://github.com/dhruvvyas90/qemu-rpi-kernel and resized the image with

```
cp 2020-02-05-raspbian-buster-lite.img resized-raspbian-buster-lite.img
qemu-img resize resized-raspbian-buster-lite.img +4G
```

I then booted it with

```
qemu-system-arm \
    -M versatilepb \
    -cpu arm1176 \
    -m 256 \
    -hda ./resized-raspbian-buster-lite.img \
    -net nic \
    -net user,hostfwd=tcp::5022-:22 \
    -dtb qemu-rpi-kernel/versatile-pb.dtb \
    -kernel qemu-rpi-kernel/kernel-qemu-4.19.50-buster \
    -append 'root=/dev/sda2 panic=1' \
    -no-reboot \
    -display none \
    -serial stdio
```

I logged in as `pi/raspberry` and resized the disk with
```
$ sudo cfdisk /dev/sda
```

Delete the second partition (sda2) and create a `New` partition with all available space. Once new partition is created, use `Write` to commit the changes. Then `Quit` cfdisk. Resize and check the old partition and shutdown.
```
$ sudo resize2fs /dev/sda2
$ sudo fsck -f /dev/sda2
$ sudo halt
```

Now I could start QEMU with the enlarged image running the previous command and prep the operating system again with the steps from above. Unfortunately, this build **failed** during the Ruby 2.6.6 build after 5 hours. 256 megabytes of RAM were insufficient and the build was on track to take well over a day.

# Conclusion

Unfortunately it appears I will have to keep doing native builds on the Raspberry Pi Zero for now. There is probably a way to use native virtualization on a 64-bit ARM processor that would be faster, but there will have to be a way to remove the 256 megabyte RAM limitation. There may be something in Build #2 that could be fixed, but having an existing working build will suffice for now.
