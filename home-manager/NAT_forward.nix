{config, pkgs, ...}:

{
	environment.etc."sysctl.d/1000-custom.conf".text = pkgs.lib.mkForce ''
  		net.ipv4.ip_forward = 1
	'';
}
