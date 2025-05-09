{ config, pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true; # Required by 1password
  home.username = "amund";
  home.homeDirectory = "/home/amund";
  home.stateVersion = "23.05";

  imports = [
    ./apps/nvim.nix
  ];

  home.packages = with pkgs; [
    git
    signal-desktop
    _1password-gui
    # Resource monitor
    gnomeExtensions.vitals # dep on gtop & lm_sensors
    gtop
    lm_sensors
    eza
    screen
  ];

  programs.home-manager.enable = true;

  dconf.settings = {
    "org/gnome/settings-daemon/plugins/color" = {
      night-light-enabled = true;
      night-light-schedule-automatic = true;
    };
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        vitals.extensionUuid
      ];
    };
    "org/gnome/shell/extensions/vitals" = {
      hot-sensors = [
      "_memory_usage_"
      "_processor_usage_"
      "__network-rx_max__"
      "__network-tx_max__"
      ];
      show-temperature = false;
      show-voltage = false;
      show-fan = false;
      show-system = false;
      show-storage = false;
    };
  };
}
