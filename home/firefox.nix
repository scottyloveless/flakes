{ ... }:
{
  programs.firefox = {
    enable = true;
    preferences = {
      "browser.startup.homepage" = "https://google.com";
      "privacy.resistFingerprinting" = true;
    };
    policies = {
      DisableTelemetry = true;
      HardwareAcceleration = true;
      OfferToSaveLogins = false;
      DefaultDownloadDirectory = "${home}/Downloads";
    };
  };
  environment.sessionVariables.MOZ_ENABLE_WAYLAND = "1";
  environment.sessionVariables.MOZ_USE_XINPUT2 = "1";
}
