{ pkgs, ... }:

{
  services.easyeffects = {
    enable = true;
    preset = "H390";
  };

  # H390 output EQ — starting point, tune by ear in the GUI.
  # No measurement data exists for this headset; corrections based on known
  # characteristics: bloated bass, slightly scooped mids, decent treble.
  xdg.configFile."easyeffects/output/H390.json".text = builtins.toJSON {
    output = {
      blocklist = [];
      "equalizer#0" = {
        balance       = 0.0;
        "input-gain"  = 0.0;
        "num-bands"   = 4;
        "output-gain" = -2.0; # Headroom to avoid clipping from the presence boost
        "pitch-left"  = 0.0;
        "pitch-right" = 0.0;
        "split-channels" = false;

        # Cut bass bloom
        band00 = {
          frequency = 120.0;
          gain      = -4.0;
          mode      = "APO, RLC (BT)";
          mute      = false;
          q         = 0.7071067690849304;
          slope     = "x1";
          solo      = false;
          type      = "Lo-shelf";
        };

        # Reduce lower-mid boxiness
        band01 = {
          frequency = 400.0;
          gain      = -1.5;
          mode      = "APO, RLC (BT)";
          mute      = false;
          q         = 1.0;
          slope     = "x1";
          solo      = false;
          type      = "Bell";
        };

        # Presence / clarity boost
        band02 = {
          frequency = 3000.0;
          gain      = 2.5;
          mode      = "APO, RLC (BT)";
          mute      = false;
          q         = 1.5;
          slope     = "x1";
          solo      = false;
          type      = "Bell";
        };

        # Air / detail
        band03 = {
          frequency = 9000.0;
          gain      = 1.5;
          mode      = "APO, RLC (BT)";
          mute      = false;
          q         = 0.7071067690849304;
          slope     = "x1";
          solo      = false;
          type      = "Hi-shelf";
        };
      };
    };
  };
}
