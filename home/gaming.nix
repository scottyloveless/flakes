{ pkgs, ... }:
{
  programs.mangohud.enable = true;

  # Steam's Linux client defaults to HTTP/2 for downloads, which often caps speed well
  # below line rate; force HTTP/1.1 and open extra parallel connections sooner.
  # (~/.steam/steam is Steam's symlink to this directory.)
  xdg.dataFile."Steam/steam_dev.cfg".text = ''
    @nClientDownloadEnableHTTP2PlatformLinux 0
    @fDownloadRateImprovementToAddAnotherConnection 1.0
  '';
}
