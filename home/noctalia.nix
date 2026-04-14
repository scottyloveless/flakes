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
      colorSchemes.predefinedScheme = "Tokyo Night";
      location = "Chelsea, AL";
      wallpaper.enabled = false;
    };
  };
}
