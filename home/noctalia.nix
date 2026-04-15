{ ... }:
{
  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        position = "top";
      };
      general = {
        radiusRatio = 0.2;
      };
      colorSchemes.predefinedScheme = "TokyoNight";
      location = "Chelsea, AL";
      wallpaper.enabled = false;
    };
  };
}
