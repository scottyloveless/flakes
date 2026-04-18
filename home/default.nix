{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [
    inputs.lazyvim.homeManagerModules.default # Use inputs
    ./zsh.nix
    ./git.nix
    ./neovim.nix
    ./lazyvim.nix
    ./oh-my-posh.nix
    ./ghostty.nix
    ./ssh.nix
    ./1password.nix
    # ./firefox.nix
  ];

  programs.home-manager.enable = true;
  programs.zoxide.enable = true;
  programs.zoxide.options = [
    "--cmd cd"
  ];

  home.packages = with pkgs; [
    ripgrep
    fd
    fzf
    bat
    eza
    btop
    gcc
    lazygit
    oh-my-posh
    statix # nix linter
    deadnix # nix linter
    pkgs.nixfmt # nix linter
    nixd # nix lsp
    alejandra # nix lsp
    gh
    yazi
    zoxide
    pkgs.weechat
    pkgs.discordo
    pkgs.signal-desktop
    swaybg
    (writeShellScriptBin "claude-app" ''
      exec ${pkgs.chromium}/bin/chromium \
        --app="https://claude.ai" \
        --class="claude-app" \
        --name="Claude" \
        "$@"
    '')
  ];

  xdg.desktopEntries.claude-app = {
    name = "Claude";
    comment = "Claude AI";
    exec = "claude-app";
    icon = "claude";
    terminal = false;
    categories = [
      "Network"
      "WebBrowser"
    ];
    startupNotify = true;
  };
}
