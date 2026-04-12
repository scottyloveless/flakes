{ pkgs, ... }:
{
    imports = [ lazyvim.homeManagerModules.default ];
    programs.lazyvim = {
      enable = true;

      installCoreDependencies = true;

      extras = {
      	lang.nix.enable = true;
	lang.go = {
	  enable = true;
	  installDependencies = true;
	  installRuntimeDependencies = true;
	};
      }; 
   };
}
