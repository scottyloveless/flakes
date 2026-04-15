{
  imports,
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/common.nix
    ../../modules/darwincommon.nix
  ];

  networking.hostName = "sandy";

}
