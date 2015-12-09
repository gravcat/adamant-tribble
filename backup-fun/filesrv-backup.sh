#!/bin/sh
# A simple script to manage backups on a local file server. May become simpler or more complex as necessary.
#	To "extract" the archive, "cat filesrv-backup-$TIME.tar.gz.* | tar xvf -" should do the trick in rejoining the files.
# gravcat, 2015-12-07

# general info and settings
version=0.1a

tar -cf - /mnt/backups/filesrv_1/ | split -d -b 8192m - /mnt/backups/staging/split/filesrv_backup_`date +%Y-%m-%d`.tar.
if [ "$?" != "0" ]; then
	echo "Issue creating tar file!" 1>&2
	exit 1
fi

mv /mnt/backups/staging/filesrv_backup_* /mnt/backups/uploady-ready/`date +%Y-%m-%d`/
if [ "$?" != "0" ]; then
	echo "Issue moving files into upload-ready directory!" 1>&2
	exit 1
fi

echo "Completed backup at `date +%Y-%m-%d-%H.%M`"

curl -X POST --data-urlencode 'payload={"channel": "#monitoring", "username": "Codsworth", "text": "Sir, the filesrv backup has been completed.", "icon_emoji": ":codsworth:"}' https://hooks.slack.com/services/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
