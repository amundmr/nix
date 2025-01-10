# This timer runs every hour to back up local work to google drive.
{config, pkgs, ...}:

{
  systemd.user.services = {
    backup_google_drive = {
      Unit = {
        Description = "Backup to Google Drive";
      };
      Service = {
        Type = "oneshot";
        ExecStart = "/home/amund/nix/home-manager/systemd_timers/rclone_copy.sh";
	StandardOutput = "journal";
	StandardError = "journal";
      };
      Install.WantedBy = [ "default.target" ];
    };
  };

  systemd.user.timers = {
    backup_google_drive = {
      Unit.Description = "Hourly timer for Backup to Google Drive";
      Timer = {
        OnCalendar = "*-*-* *:40:00";
      };
      Install.WantedBy = [ "timers.target" ];
    };
  };
}
