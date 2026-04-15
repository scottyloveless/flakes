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
      DefaultDownloadDirectory = "$HOME/Downloads";
    };
  };
}
