{ config, pkgs, ... }:

let
  GREEN = "\\[\\033[0;32m\\]";
  NOCOL = "\\[\\033[0m\\]";
in

{
  nixpkgs.config = {
    allowUnfree = true; # Required by 1password
  };
  home.username = "amund";
  home.homeDirectory = "/home/amund";
  home.stateVersion = "23.05";

  imports = [
    ./apps/nvim.nix
    ./systemd_timers/google_drive_rsync.nix
  ];

  home.packages = with pkgs; [
    git
    signal-desktop
    _1password-gui
    google-chrome
    # Resource monitor
    gnomeExtensions.vitals # dep on gtop & lm_sensors
    gtop
    lm_sensors

    gnomeExtensions.tiling-assistant
    typst
    eza
    bash
    cargo
    rustc
    shell-gpt
    rclone
  ];


  # Home-manager options list https://home-manager-options.extranix.com/?
  #home.sessionVariables = {
  #};

  #xdg.configFile."rclone/rclone.conf".text = '' ''; # TODO: paste my ~/.config/rclone/rclone.conf here. Requires password

  programs.home-manager.enable = true;
  programs.bash = {
    enable = true;
    enableCompletion = true;
    sessionVariables = {
      PS1="${GREEN}\\u@\\h${NOCOL}:${GREEN}\\w${NOCOL}\\$ ";
      EDITOR = "nvim";
    };
    shellAliases = {
      ls="eza --long --git";
    };
    initExtra = ''
      if [ -f ~/.profile ]; then
        source ~/.profile
      fi
    '';
  };

  dconf.settings = {
    "org/gnome/shell" = {
      disable-user-extensions = false;
      enabled-extensions = with pkgs.gnomeExtensions; [
        vitals.extensionUuid
        tiling-assistant.extensionUuid
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
    "org/gnome/desktop/wm/keybindings" = {
	switch-windows = ["<Alt>Tab"];
	switch-windows-backward = ["<Shift><Alt>Tab"];
	switch-applications = [];
	switch-applications-backward = [];
    };
  };
}
