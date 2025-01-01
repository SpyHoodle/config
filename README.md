# config
> SpyHoodle's Personal NixOS Configurations

## Description
A feature-rich configuration, built using flakes and Snowfall Lib. 
Everything is a module to make it easy to setup my applications and configurations across multiple systems.
This also keeps the main home and system configurations much neater and smaller.
The modules are opinionated and come with good defaults, offering little customisation.
There's modules for theming, which allows the easy swap of wallpapers, fonts or color-scheme no matter the window manager used.

## Theme (`modules/home/theme/`)
- `theme.font` - The system fonts
- `theme.cursor` - The system cursor
- `theme.style` - Light or dark theme
- `theme.colors`
    - `theme.colors.pallete` - The colors in `base1`6 variant
    - `theme.colors.accent` - The accent color to use (e.g. `base0A`) throughout the system

### Themes
- `theme.catppuccin.enable` - The default theme

## Structure
- `homes/` - My homes
- `systems/` - My systems
- `modules/home` - Home Manager modules
- `modules/nixos` - NixOS modules
