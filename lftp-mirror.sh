#!/bin/sh

# Display variables for troubleshooting
echo -e "Variables set:\\n\
PUID=${PUID}\\n\
PGID=${PGID}\\n\
HOST=${HOST}\\n\
PORT=${PORT}\\n\
USERNAME=${USERNAME}\\n\
PASSWORD=${PASSWORD}\\n\
REMOTE_DIR=${REMOTE_DIR}\\n\
TEMP_DIR=${TEMP_DIR}\\n\
FINISHED_DIR=${FINISHED_DIR}\\n\
LFTP_PARTS=${LFTP_PARTS}\\n\
LFTP_FILES=${LFTP_FILES}\\n"

while true
do
	# LFTP with specified segment & parallel
	echo "[$(date '+%H:%M:%S')] Checking ${REMOTE_DIR} for files....."

	lftp -u $USERNAME,$PASSWORD sftp://$HOST -p $PORT <<-EOF
        set ssl:verify-certificate no
        set sftp:auto-confirm yes
	    mirror -c --no-empty-dirs --Remove-source-files --Remove-source-dirs --use-pget-n=$LFTP_PARTS -P$LFTP_FILES $REMOTE_DIR $TEMP_DIR
	quit
	EOF

    if [ "$(ls -A $TEMP_DIR)" ]
    then
    	# Move finished downloads to destination directory
    	echo "[$(date '+%H:%M:%S')] Moving files....."

	chmod -R 777 $TEMP_DIR/*
        mv -fv $TEMP_DIR/* $FINISHED_DIR
    else
        echo "[$(date '+%H:%M:%S')] Nothing to download"
    fi

    # Repeat process after one minute
    echo "[$(date '+%H:%M:%S')] Sleeping for 1 minute"
    sleep 1m
done
