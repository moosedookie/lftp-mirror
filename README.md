# docker-lftp-mirror
- Description:
  - Quick &amp; dirty SFTP mirror via LFTP

- Instructions:
  - Set required environmental variables

- Variables:
  - Required
    - HOST: IP/host/url of host
    - PORT: Port of host
    - USERNAME: SSH user on host
    - PASSWORD: Pass for user on host
    - REMOTE_DIR: Directory on host to mirror locally
    - /TEMP: Path to TEMP_DIR on local machine
    - /DOWNLOADS: Path to FINISHED_DIR on local machine
    - LFTP_PARTS: Number of parts in which to split files (-use-pget[-n=N])
    - LFTP_FILES: Number of files to download in parallel (--parallel[=N])
    - PUID: UserId used to run process / file ownership
    - PGID: GroupId used to run process / file ownership
    - TEMP_DIR: Directory that files will download to (/TEMP)
    - FINISHED_DIR: Directory to place finished downloads (/DOWNLOADS)