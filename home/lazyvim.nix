{ ... }:
{
    programs.lazyvim = {
      enable = true;

      extras = {
      	lang.nix.enable = true;
	lang.go = {
	  enable = true;
	  installDependencies = true;
	  installRuntimeDependencies = true;
	};
      }; 

      extraPackages = with pkgs; [
        nixd
	alejandra
      ];
   };
}
