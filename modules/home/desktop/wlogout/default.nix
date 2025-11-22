{
  config,
  lib,
  pkgs,
  ...
}:

{
  options = {
    host.desktop.wlogout.enable = lib.mkEnableOption "Whether to use wlogout, a wayland logout menu";
  };

  config = lib.mkIf config.host.desktop.wlogout.enable {
    programs.wlogout = {
      enable = true;

      layout = [
        {
          label = "shutdown";
          action = "systemctl poweroff";
          text = "Poweroff";
          keybind = "p";
        }
        {
          label = "suspend";
          action = "systemctl suspend";
          text = "Suspend";
          keybind = "u";
        }
        {
          label = "reboot";
          action = "systemctl reboot";
          text = "Reboot";
          keybind = "r";
        }
        {
          label = "soft-reboot";
          action = "systemctl soft-reboot";
          text = "Soft Reboot";
          keybind = "s";
        }
        {
          label = "logout";
          action = "${pkgs.hyprland}/bin/hyprctl dispatch exit 0";
          text = "Logout";
          keybind = "e";
        }
      ]
      ++ lib.optional config.host.desktop.hyprlock.enable {
        label = "lock";
        action = "${pkgs.hyprlock}/bin/hyprlock --immediate";
        text = "Lock";
        keybind = "l";
      };
      style = ''
        * {
          background-image: none;
          box-shadow: none;
        }

        window {
          background-color: alpha(#${config.host.theme.colors.pallete.base00.hex}, 0.5);
        }

        button {
          background-color: #${config.host.theme.colors.pallete.base00.hex};
          text-decoration-color: #${config.host.theme.colors.pallete.base05.hex};
          color: #${config.host.theme.colors.pallete.base05.hex};
          font-family: ${config.host.theme.font.sansSerif.name};
          font-size: ${builtins.toString config.host.theme.font.sansSerif.size}px;
          border-radius: ${builtins.toString config.host.desktop.hyprland.window.rounding}px;
          border: 2px solid #${config.host.theme.colors.pallete.${config.host.theme.colors.accent}.hex};
          background-repeat: no-repeat;
          background-position: center;
          background-size: 25%;
          margin: 10px;
        }

        button:focus, button:active, button:hover {
          background-color: #${config.host.theme.colors.pallete.base02.hex};
          outline-style: none;
        }

        #lock {
          background-image: image(url("${./icons/lock.png}"));
        }

        #logout {
          background-image: image(url("${./icons/logout.png}"));
        }

        #suspend {
          background-image: image(url("${./icons/suspend.png}"));
        }

        #shutdown {
          background-image: image(url("${./icons/shutdown.png}"));
        }

        #reboot {
          background-image: image(url("${./icons/reboot.png}"));
        }

        #soft-reboot {
          background-image: image(url("${./icons/soft-reboot.png}"));
        }
      '';
    };
  };
}
