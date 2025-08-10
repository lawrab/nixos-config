# system-packages.nix - System-wide packages
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nfs-utils   # For NFS
    cifs-utils  # For SMB/CIFS
  ];
}