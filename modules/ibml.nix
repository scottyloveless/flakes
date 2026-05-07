# modules/cato-client-override.nix
{ pkgs, ... }:
let
  cato-client-newer = pkgs.cato-client.overrideAttrs (oldAttrs: rec {
    version = "5.7.0.5525";
    src = pkgs.fetchurl {
      url = "https://clients.catonetworks.com/linux/${version}/cato-client-install.deb";
      sha256 = "0gg7aq74k9976amf2j4f77l7mg77gcylyil67bi4bvb4smsh6cjh"; # placeholder
    };
  });
in
{
  nixpkgs.overlays = [
    (final: prev: {
      cato-client = cato-client-newer;
    })
  ];

  services.cato-client = {
    enable = true;
    package = cato-client-newer;
  };
}
