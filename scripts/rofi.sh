#!/usr/bin/bash

# Kill unnecessary processes
scripts=`ps -ef | grep -v "grep" | grep ".config/polybar/.*/scripts/.*" | awk -vpid=$$ '$2 != pid { print $2 }'`
for d in $scripts
do
    kill -9 $d
    wait
done

colorblocks=`ps -efww | grep -v "grep" | grep "\--colorblocks" | awk -vpid=$$ '$2 != pid { print $2 }'`
for d in $colorblocks
do
    echo "[-] The colorblocks theme $d is still running, killing it"
    kill -9 $d
    wait
done
trans=`ps -efww | grep -v "grep" | grep "\--trans" | awk -vpid=$$ '$2 != pid { print $2 }'`
for d in $trans
do
    echo "[-] The trans theme $d is still running, killing it"
    kill -9 $d
    wait
done

if [[ ! -z $(ps -efww | grep -vE "grep|launch.sh|scripts" | grep "colorblocks" | awk -vpid=$$ '$2 != pid { print $2 }') ]]; then 
    rofi -theme .config/polybar/colorblocks/scripts/rofi/launcher.rasi -show drun
elif [[ ! -z $(ps -efww | grep -vE "grep|launch.sh|scripts" | grep "trans" | awk -vpid=$$ '$2 != pid { print $2 }') ]]; then
    rofi -theme .config/polybar/trans/scripts/rofi/launcher.rasi -show drun
else
    echo "[-] A polybar theme is not running!"
fi