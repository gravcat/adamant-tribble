#!/bin/sh
# A simple script to manage backups on a local file server. May become simpler or more complex as necessary.
# gravcat, 2015-12-07

# general info and settings
version=0.2a
time=`date +%Y-%m-%d`

# tar settings
inputdir=/mnt/backups/filesrv_1
outputdir=/mnt/backups/upload-ready
outputname=filesrv-backup-"`date +%Y-%m-%d`".tar.gz

# notification settings
api1=https://hooks.slack.com/services/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


tar -cpPf $outputdir/$outputname $inputdir
echo "Completed backup at `date +%Y-%m-%d_%H.%M` (UTC [-6])."

curl -X POST --data-urlencode 'payload="text": "Sir, the filesrv backup has completed at $TIME.", "channel": "#monitoring", "username": "Codsworth", "iron_emoji": ":codsworth:"}' $api1