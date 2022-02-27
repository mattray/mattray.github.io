---
title: Enabling a USB Serial Console on Linux
---

<a href="https://www.alibaba.com/product-detail/USB-to-USB-crossover-serial-adapter_60623058382.html"><img src="/assets/usb-crossover.jpg_300x300.jpg" alt="USB Serial Crossover Cable" width="300" height="300" align="right" /></a>

Serial consoles have been used to communicate with headless networking and datacenter gear for decades. It works without requiring a screen, keyboard or networking which makes it helpful for debugging embedded devices and clusters of broken laptops and headless Arm boxes (which is my home lab). Most devices stopped shipping with serial ports years ago and USB to RS-232 serial adapters became common, but I picked up a USB to USB crossover serial adapter eliminating the need for separate cables. I purchased mine from [Alibaba.com](https://www.alibaba.com/product-detail/USB-to-USB-crossover-serial-adapter_60623058382.html), which was cheaper than the name-brand alternatives (about $25 with shipping to Australia).

## Configuring ttyUSB0

On Linux the serial console is usually available as `ttyS0`, and if it's enabled you can connect to it with tools like `screen` or `minicom`. Physical and virtual consoles are connected to serial ports and the terminal with the application `getty` ("get tty"), presenting the user with a login prompt. A USB serial console would be available as `ttyUSB0`, so you need to connect the Linux service `getty` to `ttyUSB0`. For most recent Linux versions, this is managed by [systemd](https://systemd.io/) so enabling and starting the service is as simple as:

    systemctl enable getty@ttyUSB0.service
    systemctl start getty@ttyUSB0.service

I ran this on Raspbian 10, Armbian 11, and Debian 11 x86 and Arm systems and it worked across the board. I added it to my [Chef recipe](https://github.com/mattray/mattray-cookbook/blob/main/recipes/default.rb#L88) to ensure it stayed enabled across my current and any future machines.

## Accessing the USB Serial Console with CoolTerm

I'm currently using macOS, so I initially tried out [Serial](https://www.decisivetactics.com/products/serial/) which was very impressive but seemed like overkill for my limited needs. Roger Meier's [CoolTerm](https://freeware.the-meiers.org/) serial port terminal application was simple and worked like a charm.

To connect with CoolTerm follow these steps:

1. Start the CoolTerm application
1. Connect the USB serial crossover cable. I'm using a USB-C to USB-A adapter with my M1 Macbook Air, it works just fine.
1. Go to **Options** and select the **Port** similar to `usbserial-AU03XLD7`. If it is not listed, unplug the USB cable, replug it and click **Re-Scan Serial Ports** without the cable plugged into the remote machine yet.
1. The **Baudrate** should probably be `9600`, this appears to be the default.
1. **Data Bits** should be `8`, **Parity** `None` and **Stop Bits** `1`, these are all defaults.
1. Under **Terminal** you may want to set **Filter ASCII Escape Sequences** if you use any special characters in your `PS1` or see odd characters in your terminal.
1. I didn't change any of the other defaults, it worked without having to mess with these.
1. Exit the **Options** and select **Connect**. At this point you should see a blank terminal and a timer with the number of bytes transmitted.
1. Plug the other end of the USB cable into your `ttyUSB0` enabled device and a terminal should come right up. It works exactly like a virtual console or SSH session.

Unplugging it and plugging it into another machine behaves exactly like detaching a monitor. A USB console left open will stay open and switching to other machines will bring up their prompt accordingly. Have fun!

<img src="/assets/coolterm.png" alt="CoolTerm USB TTY Output" width="812" height="672" align="center"/>
