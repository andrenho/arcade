#!/bin/bash

BUCKET=s3://andrenho-retropie-backup

# calculate uncompressed size, ask for confirmation
du -h --max-depth=0 ~/RetroPie /opt/retropie/configs ~/.aws
echo "Total files:"
find ~/RetroPie -type f | wc -l
find /opt/retropie/configs -type f | wc -l

read -p "Continue backup? (Y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then exit; fi

# upload all files

aws s3 sync /home/pi/.aws $BUCKET/.aws --storage-class ONEZONE_IA
aws s3 sync /opt/retropie/configs $BUCKET/opt_retropie_configs --storage-class ONEZONE_IA
aws s3 sync /home/pi/RetroPie $BUCKET/RetroPie --storage-class ONEZONE_IA

echo "Done."
