#!/bin/bash

BUCKET=s3://andrenho-retropie-backup

# calculate uncompressed size, ask for confirmation
du -h --max-depth=0 ~/RetroPie /opt/retropie/configs ~/.aws

read -p "Continue backup? (Y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then exit; fi

# upload all files

aws s3 sync /home/pi/.aws $BUCKET/ --storage-class STANDARD_IA
aws s3 sync /opt/retropie/configs $BUCKET/ --storage-class STANDARD_IA
aws s3 sync /home/pi/RetroPie $BUCKET/ --storage-class STANDARD_IA

echo "Done."
