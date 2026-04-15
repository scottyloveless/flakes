{ ... }:
{
  programs.firefox = {
    enable = true;
    preferences = {
      "browser.startup.homepage" = "https://example.com";
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
