#!/bin/sh
# A simple script to manage backups on a local file server. May become simpler or more complex as necessary.
#	To "extract" the archive, "cat filesrv-backup-$TIME.tar.gz.* | tar xvf -" should do the trick in rejoining the files.
# gravcat, 2015-12-07

# general info and settings
version=0.1a
time=`date +%Y-%m-%d-%H.%M`

# tar settings
inputdir=/mnt/backups/filesrv_1
outputdir=/mnt/backups/upload-ready
outputname=filesrv-backup-$TIME.tar.gz.

# notification settings
api1=https://hooks.slack.com/services/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
api3=$API1$API2

tar -cf - /mnt/backups/filesrv_1/ | split -d -b 8192m - /mnt/backups/staging/split/filesrv_backup_`date +%Y-%m-%d`.tar.
#tar -cvpf - $INPUTDIR | split --bytes=9.5GB - $OUTPUTDIR/`date +%Y-%m-%d`/$OUTPUTNAME 
#tar cf /mnt/backups/staging/filesrv_backup_staging.tar /mnt/backups/filesrv_1/
if [ "$?" != "0" ]; then
	echo "Issue creating tar file!" 1>&2
	exit 1
fi

#split -d -b 8192m /mnt/backups/staging/filesrv_backup_staging.tar /mnt/backups/staging/split/filesrv_backup_`date +%Y-%m-%d`.tar.
if [ "$?" != "0" ]; then
	echo "Issue splitting tar file!" 1>&2
	exit 1
fi

mv /mnt/backups/staging/filesrv_backup_* /mnt/backups/uploady-ready/`date +%Y-%m-%d`/
if [ "$?" != "0" ]; then
	echo "Issue moving files into upload-ready directory!" 1>&2
	exit 1
fi

#| split -bytes=9G - /mnt/backups/upload-ready/`date +%Y-%m-%d`/filesrv-backup`date +%Y-%m-%d`.tar.gz.
echo "Completed backup at $TIME." 

#curl -X POST --data-urlencode 'payload={"channel": "#monitoring", "username": "Codsworth", "text": "Sir, the filesrv backup has completed at `date +%H:%M`.", "icon_emoji": ":codsworth:"}' https://hooks.slack.com/services/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
