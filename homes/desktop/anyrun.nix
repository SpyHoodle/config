{ inputs, pkgs, ... }:

{
  programs.anyrun = {
    enable = true;
    
    config = {
      plugins = with inputs.anyrun.packages.${pkgs.stdenv.hostPlatform.system}; [
        applications
        rink
        shell
        translate
        kidex
        symbols
      ];

      x = { fraction = 0.5; };
      y = { fraction = 0.3; };
      width = { fraction = 0.3; };
      closeOnClick = true;

    };
    extraCss = ''
      #window {
        background-color: transparent;
      }
      #main * {
        background-color: #282c34;
        color: #ABB2BF;
        caret-color: alpha(#ABB2BF,0.6);
        font-family: FontAwesome, Inter;
      }
      #main {
        border-width: 3px;
        border-style: solid;
        border-color: #ABB2BF;
        border-radius: 0px;
      }
      #main #main {
        border-style: none;
        border-bottom-left-radius: 5px;
        border-bottom-right-radius: 5px;
      }
      #match-title, #match-desc {
        font-family: FontAwesome, Inter;
      }
      #entry {
        min-height: 25px;
        padding: 10px;
        font-size: 20px;
        box-shadow: none;
        border-style: none;
      }
      #entry:focus {
        box-shadow: none;
      }
      #entry selection {
        background-color: alpha(#E5C07B,0.3);
        color: transparent;
      }
    '';
  };
}
