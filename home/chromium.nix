{ ... }:
{
  programs.chromium = {
    enable = true;
    commandLineArgs = [
      "--enable-features=TouchpadOverscrollHistoryNavigation,UseOzonePlatform"
      "--ozone-platform=wayland"
    ];
  };
}
