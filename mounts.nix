# mounts.nix - Filesystem mount configuration
{ ... }:

{
  # NFS mount configuration for personal NAS
  # NOTE: This is a specific configuration for "rabnas.home:/volume1/data"
  # If you're using this repository as a template, you'll likely want to:
  # 1. Change the device path to match your NAS hostname/IP and share path
  # 2. Change the mount point from "/mnt/rabnas" to something more appropriate
  # 3. Or remove this entirely if you don't need NFS mounts
  fileSystems."/mnt/rabnas" = {
    device = "rabnas.home:/volume1/data";
    fsType = "nfs";
    options = [ 
      "x-systemd.automount"      # Auto-mount on access
      "noauto"                   # Don't mount at boot
      "x-systemd.idle-timeout=60" # Unmount after 60 seconds of inactivity
      "x-systemd.device-timeout=5s" # Timeout for device availability
      "x-systemd.mount-timeout=5s"  # Timeout for mount operation
    ];
  };

  # Example: Additional NFS mount (commented out)
  # fileSystems."/mnt/another-share" = {
  #   device = "your-nas.local:/path/to/share";
  #   fsType = "nfs";
  #   options = [ "x-systemd.automount" "noauto" ];
  # };

  # Example: SMB/CIFS mount (commented out)
  # fileSystems."/mnt/smb-share" = {
  #   device = "//server/share";
  #   fsType = "cifs";
  #   options = [ 
  #     "x-systemd.automount"
  #     "noauto"
  #     "username=your-username"
  #     "password=your-password"  # Better to use credentials file
  #     # "credentials=/path/to/credentials/file"
  #   ];
  # };
}