{
  description = "9glenda's simple Neovim flake for easy configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-22.11";
    flake-utils = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:numtide/flake-utils";
    };
    neovim-flake = {
      url = "github:neovim/neovim?dir=contrib";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Theme
    "plugin:onedark-vim" = {
      url = "github:joshdick/onedark.vim";
      flake = false;
    };
    # Git
    "plugin:gitsigns" = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    "plugin:telescope-plugin" = {
      url = "github:nvim-telescope/telescope-project.nvim";
      flake = false;
    };
    "plugin:plenary" = {
      url = "github:nvim-lua/plenary.nvim";
      flake = false;
    };
    "plugin:neovim-tree" = {
      url = "github:nvim-tree/nvim-tree.lua";
      flake = false;
    };
    "plugin:vim-nix" = {
      url = "github:LnL7/vim-nix";
      flake = false;
    };
    "plugin:lazygit" = {
      url = "github:kdheepak/lazygit.nvim";
      flake = false;
    };
    "plugin:luasnip" = {
      url = "github:L3MON4D3/LuaSnip";
      flake = false;
    };
    "plugin:which-key" = {
      url = "github:folke/which-key.nvim";
      flake = false;
    };
    "plugin:nvim-autopairs" = {
      url = "github:windwp/nvim-autopairs";
      flake = false;
    };
    "plugin:nvim-lspconfig" = {
      url = "github:neovim/nvim-lspconfig";
      flake = false;
    };
    "plugin:cmp-nvim" = {
      url = "github:hrsh7th/nvim-cmp";
      flake = false;
    };
    "plugin:cmp-nvim-lua" = {
      url = "github:hrsh7th/cmp-nvim-lua";
      flake = false;
    };
    "plugin:cmp_luasnip" = {
      url = "github:saadparwaiz1/cmp_luasnip";
      flake = false;
    };
    "plugin:cmp-path" = {
      url = "github:hrsh7th/cmp-path";
      flake = false;
    };
    "plugin:cmp-nvim-lsp" = {
      url = "github:hrsh7th/cmp-nvim-lsp";
      flake = false;
    };
    "plugin:cmp-buffer" = {
      url = "github:sar/cmp-buffer.nvim";
      flake = false;
    };
    "plugin:cmp-cmdline" = {
      url = "github:hrsh7th/cmp-cmdline";
      flake = false;
    };
    "plugin:lualine" = {
      url = "github:nvim-lualine/lualine.nvim";
      flake = false;
    };
    "plugin:telescope.nvim" = {
      url = "github:nvim-telescope/telescope.nvim";
      flake = false;
    };
    "plugin:nickel" = {
      url = "github:nickel-lang/vim-nickel";
      flake = false;
    };
    "plugin:neogit" = {
      url = "github:TimUntersberger/neogit";
      flake = false;
    };
    "plugin:neovim-dashboard" = {
      url = "github:glepnir/dashboard-nvim";
      flake = false;
    };

  };

  outputs = { self, nixpkgs, flake-utils, ... }@inputs:
    # This line makes this package availeable for all systems
    # ("x86_64-linux", "aarch64-linux", "i686-linux", "x86_64-darwin",...)
    flake-utils.lib.eachDefaultSystem (system:
      let
        # Once we add this overlay to our nixpkgs, we are able to
        # use `pkgs.neovimPlugins`, which is a map of our plugins.
        # Each input in the format:
        # ```
        # "plugin:yourPluginName" = {
        #   url   = "github:exampleAuthor/examplePlugin";
        #   flake = false;
        # };
        # ```
        # included in the `inputs` section is packaged to a (neo-)vim
        # plugin and can then be used via
        # ```
        # pkgs.neovimPlugins.yourPluginName
        # ```
        pluginOverlay = final: prev:
          let
            inherit (prev.vimUtils) buildVimPluginFrom2Nix;
            treesitterGrammars =
              prev.tree-sitter.withPlugins (_: prev.tree-sitter.allGrammars);
            plugins =
              builtins.filter (s: (builtins.match "plugin:.*" s) != null)
              (builtins.attrNames inputs);
            plugName = input:
              builtins.substring (builtins.stringLength "plugin:")
              (builtins.stringLength input) input;
            buildPlug = name:
              buildVimPluginFrom2Nix {
                pname = plugName name;
                version = "master";
                src = builtins.getAttr name inputs;

                # Tree-sitter fails for a variety of lang grammars unless using :TSUpdate
                # For now install imperatively
                #postPatch =
                #  if (name == "nvim-treesitter") then ''
                #    rm -r parser
                #    ln -s ${treesitterGrammars} parser
                #  '' else "";
              };
          in {
            neovimPlugins = builtins.listToAttrs (map (plugin: {
              name = plugName plugin;
              value = buildPlug plugin;
            }) plugins);
          };

        # Apply the overlay and load nixpkgs as `pkgs`
        pkgs = import nixpkgs {
          inherit system;
          overlays = [
            pluginOverlay
            (final: prev: {
              neovim-unwrapped =
                inputs.neovim-flake.packages.${prev.system}.neovim;
            })
          ];
        };

        # neovimBuilder is a function that takes your prefered
        # configuration as input and just returns a version of
        # neovim where the default config was overwritten with your
        # config.
        # 
        # Parameters:
        # customRC | your init.vim as string
        # viAlias  | allow calling neovim using `vi`
        # vimAlias | allow calling neovim using `vim`
        # start    | The set of plugins to load on every startup
        #          | The list is in the form ["yourPluginName" "anotherPluginYouLike"];
        #          |
        #          | Important: The default is to load all plugins, if
        #          |            `start = [ "blabla" "blablabla" ]` is
        #          |            not passed as an argument to neovimBuilder!
        #          |
        #          | Make sure to add:
        #          | ```
        #          | "plugin:yourPluginName" = {
        #          |   url   = "github:exampleAuthor/examplePlugin";
        #          |   flake = false;
        #          | };
        #          | 
        #          | "plugin:anotherPluginYouLike" = {
        #          |   url   = "github:exampleAuthor/examplePlugin";
        #          |   flake = false;
        #          | };
        #          | ```
        #          | to your imports!
        # opt      | List of optional plugins to load only when 
        #          | explicitly loaded from inside neovim
        neovimBuilder = { customRC ? "", viAlias ? true, vimAlias ? true
          , start ? builtins.attrValues pkgs.neovimPlugins, opt ? [ ]
          , debug ? false }:
          let
            myNeovimUnwrapped = pkgs.neovim-unwrapped.overrideAttrs (prev: {
              propagatedBuildInputs = with pkgs; [ pkgs.stdenv.cc.cc.lib ];
            });
          in pkgs.wrapNeovim myNeovimUnwrapped {
            inherit viAlias;
            inherit vimAlias;
            configure = {
              customRC = customRC;
              packages.myVimPackage = with pkgs.neovimPlugins; {
                start = start;
                opt = opt;
              };
            };
          };
      in rec {
        nixosModule = { config, lib, pkgs, ... }:
        with lib;
        let
          cfg = config.neovim-flake.neovim;
        in
        {
          options.neovim-flake.neovim = {
            enable = mkEnableOption "Enables neovim";
          };

          config = mkIf cfg.enable {
            environment.systemPackages = [
              self.packages.${system}.neovimGlenda
            ];
        };
        };

        defaultApp = apps.nvim;
        defaultPackage = packages.neovimGlenda;

        apps.nvim = {
          type = "app";
          program = "${defaultPackage}/bin/nvim";
        };

        packages = {
          neovimGlenda = neovimBuilder {
            # the next line loads a trivial example of a init.vim:
            # customRC = pkgs.lib.readFile ./${packages.config}/bin/init.vim;

            customRC = "luafile ${packages.config}/bin/config/init.lua";
            # if you wish to only load the onedark-vim colorscheme:
            # start = with pkgs.neovimPlugins; [ onedark-vim neovim-tree ];
          };
          config = pkgs.stdenv.mkDerivation {
            name = "config";
            src = ./.;
            installPhase = ''
              mkdir -p $out/bin
              cp -r config $out/bin
              cp init.vim $out/bin
            '';
          };
        };
      });
}
