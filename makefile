# Trying to avoid weird side-effects of Make. Not yet sure details, but see:
#		https://wiki.hpcc.msu.edu/display/~colbrydi@msu.edu/2012/03/05/Makefile+Mystery
#		https://www.gnu.org/software/make/manual/html_node/Phony-Targets.html
# Without this, Make would always do "cat build.sh >build; chmod a+x build", whenever I did have a file called "build.sh".
.PHONY: build
# FOUND THE PROBLEM!  The issue with *.sh files is due to "Implicit Rules" (aka Built-In Rules), specificaly one rule
# added "for the benefit of SCCS". To prevent this implicit rule's action, must use the above ".PHONY" rule.
#		https://www.gnu.org/software/make/manual/html_node/Catalogue-of-Rules.html#Catalogue-of-Rules

build:  make-image

# See section "With Apache" on this page: https://hub.docker.com/_/php/
make-image:
	docker build -t weathsnap-app .

# Whichever docker registry you set with "docker login" command
publish-image-docker-hub:
	docker tag weathsnap-app weathsnap-app:latest
	docker push weathsnap-app:latest

# Public docker registry in Docker Hub. Amazon ECS Fargate does not support private docker registries other than those in Amazon ECR.
publish-image-docker-hub-dromedaria:
	docker tag weathsnap-app dromedaria/weathsnap-app:latest
	docker push dromedaria/weathsnap-app:latest

root@raspberrypi:/home/pi# wget -q -O - https://storage.z-wave.me/RaspbianInstall | sudo bash
Hit:1 http://archive.raspberrypi.org/debian buster InRelease
Hit:2 http://raspbian.raspberrypi.org/raspbian buster InRelease        
Get:3 https://repo.z-wave.me/z-way/raspbian stretch InRelease [1,810 B]
Get:4 https://repo.z-wave.me/z-way/raspbian stretch/main armhf Packages [1,076 B]
Fetched 2,886 B in 2s (1,485 B/s)
Reading package lists... Done
W: Skipping acquire of configured file 'contrib/binary-armhf/Packages' as repository 'https://repo.z-wave.me/z-way/raspbian stretch InRelease' doesn't have the component 'contrib' (component misspelt in sources.list?)
W: Skipping acquire of configured file 'contrib/i18n/Translation-en_US' as repository 'https://repo.z-wave.me/z-way/raspbian stretch InRelease' doesn't have the component 'contrib' (component misspelt in sources.list?)
W: Skipping acquire of configured file 'contrib/i18n/Translation-en' as repository 'https://repo.z-wave.me/z-way/raspbian stretch InRelease' doesn't have the component 'contrib' (component misspelt in sources.list?)
W: Skipping acquire of configured file 'contrib/i18n/Translation-en_US.UTF-8' as repository 'https://repo.z-wave.me/z-way/raspbian stretch InRelease' doesn't have the component 'contrib' (component misspelt in sources.list?)
Reading package lists... Done
Building dependency tree       
Reading state information... Done
apt-transport-https is already the newest version (1.8.2).
dirmngr is already the newest version (2.2.12-1+rpi1).
The following packages were automatically installed and are no longer required:
  python3-pyperclip python3-thonny rpi.gpio-common
Use 'apt autoremove' to remove them.
0 upgraded, 0 newly installed, 0 to remove and 0 not upgraded.
Executing: /tmp/apt-key-gpghome.8HMhKmUphZ/gpg.1.sh --keyserver keyserver.ubuntu.com --recv-keys 7E148E3C
gpg: keyserver receive failed: Server indicated a failure
Hit:1 http://raspbian.raspberrypi.org/raspbian buster InRelease
Hit:2 http://archive.raspberrypi.org/debian buster InRelease           
Hit:3 https://repo.z-wave.me/z-way/raspbian stretch InRelease          
Reading package lists... Done
W: Skipping acquire of configured file 'contrib/binary-armhf/Packages' as repository 'https://repo.z-wave.me/z-way/raspbian stretch InRelease' doesn't have the component 'contrib' (component misspelt in sources.list?)
W: Skipping acquire of configured file 'contrib/i18n/Translation-en_US.UTF-8' as repository 'https://repo.z-wave.me/z-way/raspbian stretch InRelease' doesn't have the component 'contrib' (component misspelt in sources.list?)
W: Skipping acquire of configured file 'contrib/i18n/Translation-en' as repository 'https://repo.z-wave.me/z-way/raspbian stretch InRelease' doesn't have the component 'contrib' (component misspelt in sources.list?)
W: Skipping acquire of configured file 'contrib/i18n/Translation-en_US' as repository 'https://repo.z-wave.me/z-way/raspbian stretch InRelease' doesn't have the component 'contrib' (component misspelt in sources.list?)
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following packages were automatically installed and are no longer required:
  python3-pyperclip python3-thonny rpi.gpio-common
Use 'apt autoremove' to remove them.
The following additional packages will be installed:
  gawk libavahi-client-dev libavahi-common-dev libavahi-compat-libdnssd-dev libavahi-compat-libdnssd1 libdbus-1-dev
  libsigsegv2 sharutils webif z-way-server zbw
Suggested packages:
  gawk-doc sharutils-doc bsd-mailx | mailx
The following NEW packages will be installed:
  gawk libavahi-client-dev libavahi-common-dev libavahi-compat-libdnssd-dev libavahi-compat-libdnssd1 libdbus-1-dev
  libsigsegv2 sharutils webif z-way-full z-way-server zbw
0 upgraded, 12 newly installed, 0 to remove and 0 not upgraded.
Need to get 22.8 MB of archives.
After this operation, 6,368 kB of additional disk space will be used.
Get:1 http://mirror.web-ster.com/raspbian/raspbian buster/main armhf libsigsegv2 armhf 2.12-2 [32.3 kB]
Get:2 https://repo.z-wave.me/z-way/raspbian stretch/main armhf z-way-server armhf 3.0.0 [21.1 MB]         
Get:3 http://mirror.web-ster.com/raspbian/raspbian buster/main armhf gawk armhf 1:4.2.1+dfsg-1 [590 kB]
Get:4 http://mirror.web-ster.com/raspbian/raspbian buster/main armhf libavahi-common-dev armhf 0.7-4+b1 [65.1 kB]    
Get:5 http://mirror.web-ster.com/raspbian/raspbian buster/main armhf libdbus-1-dev armhf 1.12.16-1 [219 kB]          
Get:6 http://mirror.web-ster.com/raspbian/raspbian buster/main armhf libavahi-client-dev armhf 0.7-4+b1 [64.1 kB]    
Get:7 http://mirror.web-ster.com/raspbian/raspbian buster/main armhf libavahi-compat-libdnssd1 armhf 0.7-4+b1 [46.4 kB]
Get:8 http://mirror.web-ster.com/raspbian/raspbian buster/main armhf libavahi-compat-libdnssd-dev armhf 0.7-4+b1 [61.5 kB]
Get:9 http://mirror.web-ster.com/raspbian/raspbian buster/main armhf sharutils armhf 1:4.15.2-4 [235 kB]             
Get:10 https://repo.z-wave.me/z-way/raspbian stretch/main armhf webif armhf 1.1 [325 kB]                             
Get:11 https://repo.z-wave.me/z-way/raspbian stretch/main armhf zbw all 1.1 [4,644 B]                                
Get:12 https://repo.z-wave.me/z-way/raspbian stretch/main armhf z-way-full all 1.0-latest-version [822 B]            
Fetched 22.8 MB in 7s (3,310 kB/s)                                                                                   
Selecting previously unselected package libsigsegv2:armhf.
(Reading database ... 154769 files and directories currently installed.)
Preparing to unpack .../libsigsegv2_2.12-2_armhf.deb ...
Unpacking libsigsegv2:armhf (2.12-2) ...
Setting up libsigsegv2:armhf (2.12-2) ...
Selecting previously unselected package gawk.
(Reading database ... 154778 files and directories currently installed.)
Preparing to unpack .../00-gawk_1%3a4.2.1+dfsg-1_armhf.deb ...
Unpacking gawk (1:4.2.1+dfsg-1) ...
Selecting previously unselected package libavahi-common-dev:armhf.
Preparing to unpack .../01-libavahi-common-dev_0.7-4+b1_armhf.deb ...
Unpacking libavahi-common-dev:armhf (0.7-4+b1) ...
Selecting previously unselected package libdbus-1-dev:armhf.
Preparing to unpack .../02-libdbus-1-dev_1.12.16-1_armhf.deb ...
Unpacking libdbus-1-dev:armhf (1.12.16-1) ...
Selecting previously unselected package libavahi-client-dev:armhf.
Preparing to unpack .../03-libavahi-client-dev_0.7-4+b1_armhf.deb ...
Unpacking libavahi-client-dev:armhf (0.7-4+b1) ...
Selecting previously unselected package libavahi-compat-libdnssd1:armhf.
Preparing to unpack .../04-libavahi-compat-libdnssd1_0.7-4+b1_armhf.deb ...
Unpacking libavahi-compat-libdnssd1:armhf (0.7-4+b1) ...
Selecting previously unselected package libavahi-compat-libdnssd-dev:armhf.
Preparing to unpack .../05-libavahi-compat-libdnssd-dev_0.7-4+b1_armhf.deb ...
Unpacking libavahi-compat-libdnssd-dev:armhf (0.7-4+b1) ...
Selecting previously unselected package sharutils.
Preparing to unpack .../06-sharutils_1%3a4.15.2-4_armhf.deb ...
Unpacking sharutils (1:4.15.2-4) ...
Selecting previously unselected package z-way-server.
Preparing to unpack .../07-z-way-server_3.0.0_armhf.deb ...
Unpacking z-way-server (3.0.0) ...
Selecting previously unselected package webif.
Preparing to unpack .../08-webif_1.1_armhf.deb ...
Unpacking webif (1.1) ...
Selecting previously unselected package zbw.
Preparing to unpack .../09-zbw_1.1_all.deb ...
Unpacking zbw (1.1) ...
Selecting previously unselected package z-way-full.
Preparing to unpack .../10-z-way-full_1.0-latest-version_all.deb ...
Unpacking z-way-full (1.0-latest-version) ...
Setting up gawk (1:4.2.1+dfsg-1) ...

Configuration file '/etc/profile.d/gawk.csh', does not exist on system.
Installing new config file as you requested.

Configuration file '/etc/profile.d/gawk.sh', does not exist on system.
Installing new config file as you requested.
Setting up libavahi-compat-libdnssd1:armhf (0.7-4+b1) ...
Setting up libdbus-1-dev:armhf (1.12.16-1) ...
Setting up libavahi-common-dev:armhf (0.7-4+b1) ...
Setting up sharutils (1:4.15.2-4) ...
Processing triggers for libc-bin (2.28-10+rpi1) ...
Processing triggers for systemd (241-5+rpi1) ...
Processing triggers for man-db (2.8.5-2) ...
Processing triggers for sgml-base (1.29) ...
Processing triggers for install-info (6.5.0.dfsg.1-4+b1) ...
Setting up libavahi-client-dev:armhf (0.7-4+b1) ...
Setting up libavahi-compat-libdnssd-dev:armhf (0.7-4+b1) ...
Setting up z-way-server (3.0.0) ...

Configuration file '/etc/init.d/z-way-server', does not exist on system.
Installing new config file as you requested.

Configuration file '/etc/logrotate.d/z-way-server', does not exist on system.
Installing new config file as you requested.

Configuration file '/etc/z-way/box_type', does not exist on system.
Installing new config file as you requested.

Configuration file '/opt/z-way-server/config.xml', does not exist on system.
Installing new config file as you requested.

Configuration file '/opt/z-way-server/config/Defaults.xml', does not exist on system.
Installing new config file as you requested.
Setting default automation config
Raspberry Pi 3 Detected. Disabling Bluetooth
Removed /etc/systemd/system/multi-user.target.wants/hciuart.service.
Adding 'dtoverlay=pi3-disable-bt' to /boot/config.txt
Usage: ./z-cfg-update <filename>
Starting z-way-server: done.
Setting up webif (1.1) ...

Configuration file '/etc/webif.conf', does not exist on system.
Installing new config file as you requested.

Configuration file '/etc/mongoose/mongoose.conf', does not exist on system.
Installing new config file as you requested.
[ ok ] Starting mongoose (via systemctl): mongoose.service.
Setting up zbw (1.1) ...

Configuration file '/etc/zbw/userid', does not exist on system.
Installing new config file as you requested.

Configuration file '/etc/zbw/passwd', does not exist on system.
Installing new config file as you requested.

Configuration file '/etc/zbw/local_port', does not exist on system.
Installing new config file as you requested.

Configuration file '/etc/zbw/flags/.keep', does not exist on system.
Installing new config file as you requested.
tail: cannot open '/etc/init.d/zbw_connect' for reading: No such file or directory
chmod: cannot access 'zbw_connect': No such file or directory
zbw_connect patched
/var/lib/dpkg/info/zbw.postinst: 91: /var/lib/dpkg/info/zbw.postinst: /etc/init.d/zbw_connect: Permission denied
--2019-08-19 23:57:48--  https://find.z-wave.me/zbw_new_user
Resolving find.z-wave.me (find.z-wave.me)... 46.20.244.72, 78.46.43.211, 185.25.224.206, ...
Connecting to find.z-wave.me (find.z-wave.me)|46.20.244.72|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: unspecified [application/octet-stream]
Saving to: ‘/tmp/zbw_connect_setup.run’

/tmp/zbw_connect_se     [ <=>                ]   6.09K  --.-KB/s    in 0s      

2019-08-19 23:57:51 (31.0 MB/s) - ‘/tmp/zbw_connect_setup.run’ saved [6240]

Do you want to enable the remote support(y/n)? Remote support NOT enabled
Now you can run zbw_connect with /etc/init.d/zbw_connect start
or simply reboot your system

Your user id: 140876
Your password: rohMahcahV1a
[ ok ] Starting zbw_connect (via systemctl): zbw_connect.service.
zbw_autosetup.service is not a native service, redirecting to systemd-sysv-install.
Executing: /lib/systemd/systemd-sysv-install enable zbw_autosetup
[ ok ] Starting zbw_connect (via systemctl): zbw_connect.service.
Setting up z-way-full (1.0-latest-version) ...
Processing triggers for systemd (241-5+rpi1) ...
root@raspberrypi:/home/pi# 
root@raspberrypi:/home/pi# 
root@raspberrypi:/home/pi# 
root@raspberrypi:/home/pi# 
root@raspberrypi:/home/pi# 
root@raspberrypi:/home/pi# 
root@raspberrypi:/home/pi# 
root@raspberrypi:/home/pi# 
root@raspberrypi:/home/pi# 
root@raspberrypi:/home/pi# 
root@raspberrypi:/home/pi# 
root@raspberrypi:/home/pi# 
root@raspberrypi:/home/pi# 
root@raspberrypi:/home/pi# 
root@raspberrypi:/home/pi# cat /etc/zbw/passwd 
cm9oTWFoY2FoVjFh
root@raspberrypi:/home/pi# cat /etc/zbw/userid 
140876
root@raspberrypi:/home/pi# 
