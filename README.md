# Raspberry Spy

A remote control interface for the Raspberry Pi camera (v2.0) using bash and  JavaScript.

Primarily this is a time-lapse utility. The interface is accessible via a browser, and can be used to control the main camera settings. 



## Features overview





## Worth mentioning

- [websocketd](https://github.com/joewalnes/websocketd) - is the library required to fulfil the bash WebSocket implementation. 
  - This project uses [version 03.1](https://github.com/joewalnes/websocketd/releases) which needs to be installed separately. 
  - You can download compiled binaries for various operating systems from [http://websocketd.com/](http://websocketd.com/)
- Daytime is provided by [sunrise-sunset.org](<https://sunrise-sunset.org/>) API (for sequences between sunrise and sunset)
- Auto-start, after power re-cycle, requires a crontab @reboot entry
- Daily maintenance requires an external rsync server (to backup and delete local images)



### Main interface

![pi-spy-interface](/home/bruce/Projects/github/raspberry/docs/images/pi-spy-interface.png)

**icons from left to right:** settings menu, composition grid, last image time, progress bar, interval value, sunrise time, sunset time, disk usage, image count, recording status.

### Camera settings

![pi-spy-settings](/home/bruce/Projects/github/raspberry/docs/images/pi-spy-settings.png)

