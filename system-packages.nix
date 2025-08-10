# system-packages.nix - System-wide packages
{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nfs-utils   # For NFS filesystem support
    cifs-utils  # For SMB/CIFS filesystem support
  ];
}