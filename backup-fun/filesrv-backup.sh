#!/bin/sh
# A simple script to manage backups on a local file server. May become simpler or more complex as necessary.
#	To "extract" the archive, "cat filesrv-backup-$TIME.tar.gz.* | tar xzvf" should do the trick in rejoining the files.
# gravcat, 2015-12-07

# general info and settings
version=0.1a
time=`date +%Y-%m-%d-%H.%M`

# tar settings
inputdir=/mnt/backups/filesrv_1
outputdir=/mnt/backups/upload-ready
outputname=filesrv-backup-$TIME.tar.gz.

# notification settings
api1=https://hooks.slack.com/
api2=services/T0CUBMMGC/B0G3HBAR1/4WfH9labHb4BpnAxNhCOD4DX
api3=$API1$API2


tar cpzf -$INPUTDIR/ | split --bytes=9.5GB - $OUTPUTDIR/`date +%Y-%m-%d`/$OUTPUTNAME 
echo "Completed backup at $TIME." 

curl -X POST --data-urlencode 'payload="text": "Sir, the filesrv backup has completed at $time.", "channel": "#monitoring", "username": "Codsworth", "iron_emoji": ":codsworth:"}' $API3