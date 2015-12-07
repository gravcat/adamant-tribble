#!/bin/sh
# A simple script to manage backups on a local file server. May become simpler or more complex as necessary.
# gravcat, 2015-12-07

version = 0.1a
time=`date +%Y-%m-%d-%H.%M`
inputdir=/mnt/backups/filesrv_1
outputdir=/mnt/backups/upload-ready
outputname=filesrv-backup-$TIME.tar.gz
api1=https://hooks.slack.com/
api2=services/T0CUBMMGC/B0G3HBAR1/4WfH9labHb4BpnAxNhCOD4DX
api3=$api1$api2


tar -cpzf $outputdir/$outputname $inputdir
echo "Completed backup at $time."

curl -X POST --data-urlencode 'payload="text": "Sir, the filesrv backup has completed at $time.", "channel": "#monitoring", "username": "Codsworth", "iron_emoji": ":codsworth:"}' $api3