{ pkgs, ... }:
{
  services.cato-client = {
    enable = true;
    version = "5.7.0.5525";
  };
}
