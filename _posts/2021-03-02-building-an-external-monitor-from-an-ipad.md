# Building an External 9.7" Monitor from an iPad

I've always had a soft spot for [repurposing old hardware](/2020/06/15/upgrading-macbook-pro-ssds-updated) so when I stumbled across the video [Build a DIY screen out of recycled parts for cheap](https://www.youtube.com/watch?v=CfirQC99xPc) I knew I had to see what I could build. Sure there is lots of software for the iPad that will allow you to use it as an external monitor, but mine was an original 2010 iPad model that could no longer connect to the Apple store to install new packages.

## Lenovo Thinkpad Yoga 12

After watching the [linked video](https://www.youtube.com/watch?v=CfirQC99xPc) I originally disassembled a broken [Lenovo ThinkPad Yoga 12](https://www.insidemylaptop.com/lenovo-thinkpad-yoga-12-disassembly/) and scavenged the reusable parts out of it: Samsung SSD, Intel AC 7265 wireless card, the USB camera, and the screen. The Samsung SSD went into my kids' gaming machine as an extra 192GB drive. The Intel wireless card could be used in my AMD workstation, I just haven't hooked it up because I already have an ethernet connection. I found the model of the Lenovo screen from the [Hardware Maintenance Manual](https://download.lenovo.com/pccbbs/mobiles_pdf/yoga_12_hmm_en_sp40a27258.pdf) and ordered the proper [HDMI LCD controller board](https://www.aliexpress.com/item/4001364202221.html?spm=a2g0s.9042311.0.0.28774c4dH1GIM9) for $13.50 USD with shipping from AliExpress. It showed up, I plugged it in, and it worked at 1920x1080 resolution! Unfortunately I broke the screen trying to remove it from the laptop lid, so I had to start over.

## 2010 iPad

After nearly succeeding with my first attempt at building an external monitor, I knew I wanted to try again. My other "broken" laptops are still in use as Linux servers, but I had an original iPad that I had barely used since it stopped receiving iOS updates several years ago. I followed [iFixit's iPad Wi-Fi Display Frame Replacement](https://www.ifixit.com/Guide/iPad+Wi-Fi+Display+Frame+Replacement/2209) to disassemble it, but stopped short of removing it from the glass front (lesson learned). I then went back to AliExpress and found what looked like the right model [HDMI VGA LCD controller](https://www.aliexpress.com/item/1005001719139974.html?spm=a2g0s.9042311.0.0.28774c4dH1GIM9) for about $19 with shipping.

A few weeks later it finally showed up and didn't work. Did I have a bad unit, had I broken my iPad screen, or had I done something wrong?

## Try, Try Again

Undeterred, I decided to try AliExpress again. You'd think with a name like [Yqwsyxl LCD parts Store](https://www.aliexpress.com/store/910350379?spm=a2g0s.9042311.0.0.28774c4dH1GIM9) you'd get quality, but I decided since I was already down $19 I'd go with [CZHAO Accessories Store](https://www.aliexpress.com/store/5793675?spm=a2g0s.9042311.0.0.28774c4dH1GIM9) and pay the $21 premium (with international shipping). AliExpress prices and shipping times seem to vary wildly in response to US, Australian, and Chinese currency fluctuations and this took nearly 6 weeks to show up.

## Success!

Once it finally arrived, I [connected the HDMI LCD controller](/assets/lcd-back.JPG) to the display. I connected an HDMI cable, a 12v power adapter and turned it on. It powered up, the OSD display came on and reported "Looking for Source". I plugged it into my laptop and it appeared as a 1024x768 VGA monitor. <a href="/assets/first-boot.JPG"><img src="/assets/first-boot.JPG" alt="monitors" width="365" height="282" align="right"/></a>

## Usage

Once I had it working, I ordered a [gooseneck tablet stand](https://amzn.to/3rdcO7t) and set it up next to my main 32" monitor, above my laptop. I was using it primarily for terminals, my calendar, or Slack but my son convinced me "you have too many monitors and I only have my laptop", so now he uses it for Discord. For about $35, you should be able to convert an old laptop or tablet to a working external monitor with a stand.
<a href="/assets/monitors.JPG"><img src="/assets/monitors.JPG" alt="monitors" width="438" height="294" align="center"/></a>
