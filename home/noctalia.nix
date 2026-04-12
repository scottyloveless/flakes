{ ... }:
{
  programs.noctalia-shell = {
    enable = true;
    settings = {
      bar = {
        position = "top";
        density = "compact";
      };
      general = {
        radiusRatio = 0.2;
      };
    };
  };
}
