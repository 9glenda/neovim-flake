{ config, lib, pkgs, ...}:

with lib;
with builtins;
let
  cfg = config.neovim;

in {
  options.neovim = {
    viAlias = mkOption {
      description = "Enable vi alias";
      type = types.bool;
      default = true;
    };

    vimAlias = mkOption {
      description = "Enable vim alias";
      type = types.bool;
      default = true; 
    };
    configRC = mkOption {
      description = ''vimrc contents'';
      type = types.lines;
      default = "";
    };

    luaConfigRC = mkOption {
      description = ''vim lua config'';
      type = types.lines;
      default = "";
    };
  };
  config = {
    environment.systemPackages = [
      (neovimBuilder {
        luaConfigRC = cfg.luaConfigRC;
    })
      
    ];

  };
}
