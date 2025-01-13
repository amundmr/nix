# This timer runs every hour to back up local work to google drive.
{config, pkgs, ...}:
# NB: You may need to run `sudo systemctl --user start backup_google_drive.timer` the
# first time after initializing this on a new machine to get it started.


{
  systemd.user.services = {
    backup_google_drive = {
      Unit = {
        Description = "Backup to Google Drive";
      };
      Service = {
        Type = "oneshot";
        #ExecStart = "/home/amund/nix/home-manager/systemd_timers/rclone_copy.sh";
	ExecStart = "${pkgs.writeShellScript "backup_google_drive" ''
	#!/bin/bash
	# Copies from local directories to google drive. Sort of a backup.
	
	echo "$(date) Running rclone copy from code to remote."
	${pkgs.rclone}/bin/rclone copy --max-age 48h /home/amund/Documents/PhD-Amund/code/ Gdrive:PhD/PhD-Amund/code
	
	echo "$(date) Running rclone copy from data to remote."
	${pkgs.rclone}/bin/rclone copy --max-age 48h /home/amund/Documents/PhD-Amund/data/ Gdrive:PhD/PhD-Amund/data
	
	echo "$(date) Running rclone copy from untracked digichar repo sandbox to remote Projects/digichar_sandbox."
	${pkgs.rclone}/bin/rclone copy --max-age 48h /home/amund/Documents/git/digichar/sandbox Gdrive:Projects/digichar_sandbox
	
	echo "$(date) Completed rclone jobs for this hour."
      ''}";
        RemainAfterExit = false;
	StandardOutput = "journal";
	StandardError = "journal";
      };
      Install.WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers = {
    backup_google_drive = {
      # Unit = # Not required, as it by default selects the service with the same name
      Unit.Description = "Hourly timer for Backup to Google Drive";
      Timer = {
        OnCalendar = "*-*-* *:50:00";
	Persistent = true;
      };
      Install.WantedBy = [ "timers.target" ];
    };
  };
}
