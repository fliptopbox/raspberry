# Raspberry Spy

A remote control interface for the Raspberry Pi camera (v2.0) using bash and  JavaScript.

Essentially this project is a time-lapse utility, accessible via a browser, to control the camera. The back-end is a pure bash implementation, which uses WebSockets to read and write camera settings, that update interface metadata and change camera parameters in real-time.



## Features overview

- **Daytime stop/start** - sync your camera's activity to dawn and dusk.
- **Time-lapse bracketing** - use exposure compensated images sequences.
- **Automatic space retrieval** - automatically backup and delete local photos.



## Worth mentioning

- [websocketd](https://github.com/joewalnes/websocketd) - is the library required to fulfil the bash WebSocket implementation. 
  - This project uses [version 0.3.1](https://github.com/joewalnes/websocketd/releases) which needs to be installed separately. 
  - You can download pre-compiled binaries for your OS  from [http://websocketd.com/](http://websocketd.com/)
- Daytime is provided by [sunrise-sunset.org](<https://sunrise-sunset.org/>) API (for sequences between sunrise and sunset)
- Auto-start, after power re-cycle, requires a crontab @reboot entry
- Daily maintenance requires an external rsync server (to backup and delete local images)



### Main interface

![pi-spy-interface](./docs/assets/greeting.jpg)

**Icons from left to right:** settings menu, composition grid, last image time, progress bar, interval value, sunrise time, sunset time, disk usage, image count, recording status.

### Camera settings

![pi-spy-settings](./docs/assets/settings.jpg)

