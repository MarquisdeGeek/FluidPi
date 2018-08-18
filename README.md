# FluidPi
A headless Raspberry Pi synth with web-controlled patches

## Intro
I have several Raspberry Pi's that are not earning their keep, so I decided to buy some SD cards
and turn them into permanently-configured embedded devices. The first one is this - a synth!

It uses SF2 soundfont files to generate the noises, and is controlled by a USB MIDI controller.

It uses a web server in bash (really!) to control the sounds remote, so it can be run headless.

## Installation
There are several moving parts here:
* OS : Raspbian : https://www.raspberrypi.org/downloads/raspbian/
* Software : Utility software: apt get install fluidsynth alsa socat
* Configuration : Append the config/rc.local to etc/rc.local

The guide with which I started was at andrewdotni.ch/blog/2015/02/28/midi-synth-with-raspberry-p/

I use this as a base, with all the code in /home/synth but run by the root user on boot-up. This
isn't recommended (especially since it runs the web server as root) but it gets the job done, on
a local network.

Copy all the SF2 soundfont files you have into /home/synth/sf2, as this where the webserver will
scan.

There maybe some other steps which I've forgotten.

## Features
On boot-up the device:
* Loads the FluidSynth software
* Opens a session on port 9987 into which you can telnet, to control FluidSynth
* Opens a web server on port 9988 to change SF2 files
* Connects a MIDI keyboard input device (ID 128), to the FluidSynth output device (ID 20)
* Plays some notes to let you know it's ready

## Credits
Inspiration: http://andrewdotni.ch/blog/2015/02/28/midi-synth-with-raspberry-p/
FluidSynthh: http://www.fluidsynth.org
Service scripts: https://gist.github.com/oostendo/b22a57aacc9439f80f74b0545d38148d 
  https://gist.github.com/oostendo/7bd7efeebd2dc135e17a077326469b24 (not used)
bashhttpd: https://github.com/avleen/bashttpd


