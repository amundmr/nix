#!/bin/bash
# Copies from local directories to google drive. Sort of a backup.
echo "$(date) Running rclone copy from code to remote."
rclone copy --max-age 48h /home/amund/Documents/PhD-Amund/code/ Gdrive:PhD/PhD-Amund/code
echo "$(date) Running rclone copy from data to remote."
rclone copy --max-age 48h /home/amund/Documents/PhD-Amund/data/ Gdrive:PhD/PhD-Amund/data
echo "$(date) Running rclone copy from untracked digichar repo sandbox to remote Projects/digichar_sandbox."
rclone copy --max-age 48h /home/amund/Documents/git/digichar/sandbox Gdrive:Projects/digichar_sandbox
echo "$(date) Completed rclone jobs for this hour."
