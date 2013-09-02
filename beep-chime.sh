#!/bin/sh
#
# (C)Shinichiro HIDA <shinichiro@stained-g.net>
# License: GPLv3
#
# Created: Fri, Aug 30 10:01:38 JST 2013 
# Last modified: Mon, Sep 02 10:25:31 JST 2013
#
# This script play sound of Westminster Chime which is very common in
# Japanese school, with beep on your PC speaker. It is good to use
# this with your cron, also it is better to set the time correctly
# with ntp service.
#
# Name: beep-chime.sh
# Required: beep [deb]    - http://packages.debian.org/beep
#                [origin] - http://www.johnath.com/beep/
# References: file:///usr/share/doc/beep/, man(1) beep

## Begin
# checking beep command.

BEEP=""

# Search path for beep command. Last found one is used.
PATH=/bin:/usr/bin:/usr/local/bin:/home/$USER/bin

for i in `echo $PATH | sed -e 's/:/ /g'`
do
    if [ -r $i/beep -a -x $i/beep ]; then
#	echo "$i/beep found."
	BEEP="$i/beep"
    else
#	echo "$i/beep not found.. trying next path.."
	:
    fi
done

if [ -z $BEEP ]; then
    echo "Error: beep command not found.. please install beep command. exited."
    exit 1
fi

# C Major scale tone (Hz) 0-2000
C0="261.6"
D0="293.7"
E0="329.6"
F0="349.2"
G0="392.0"
A1="440.0"
B1="493.9"
C1="523.2"

# C Major scale
# for i in $C0 $D0 $E0 $F0 $G0 $A1 $B1 $C1
# do
#    beep -f $i
# done

for i in $A1 $F0 $G0 
do
    $BEEP -l 500 -f $i
done

$BEEP -l 1000 -f $C0
sleep 0.5

for i in $C0 $G0 $A1 
do
    $BEEP -l 500 -f $i
done

count=1
while test $count -lt 5
do
    $BEEP -l 1000 -f $F0
    sleep 0.5
    count=`expr $count + 1`
done

## END
