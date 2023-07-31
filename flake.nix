{
  description = "9glenda's simple Neovim flake for easy configuration";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    flake-utils = {
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

    "plugin:fmt" = {
      url = "github:lukas-reineke/lsp-format.nvim";
      flake = false;
    };
    "plugin:rust-lsp" = {
      url = "github:simrat39/rust-tools.nvim";
      flake = false;
    };

    "plugin:nvim-dap" = {
      url = "github:mfussenegger/nvim-dap";
      flake = false;
    };

    "plugin:tree-sitter" = {
      url = "github:nvim-treesitter/nvim-treesitter";
      flake = false;
    };

    "plugin:neorg" = {
      url = "github:nvim-neorg/neorg";
      flake = false;
    };
    # Reading

    "plugin:easyread.nvim" = {
      url = "github:JellyApple102/easyread.nvim";
      flake = false;
    };
    # markdown

    "plugin:markdown-preview" = {
      url = "github:iamcco/markdown-preview.nvim";
      flake = false;
    };

    #    "plugin:markdown-preview2" = {
    #      url = "github:euclio/vim-markdown-composer";
    #      flake = false;
    #    };
    "plugin:peek" = {
      url = "github:toppair/peek.nvim";
      flake = false;
    };
    "plugin:mkdnflow.nvim" = {
      url = "github:jakewvincent/mkdnflow.nvim";
      flake = false;
    };
    "plugin:md-headers.nvim" = {
      url = "github:AntonVanAssche/md-headers.nvim";
      flake = false;
    };
    "plugin:glow" = {
      url = "github:ellisonleao/glow.nvim";
      flake = false;
    };
    # coc
    #    "plugin:coc" = {
    #      url = "github:neoclide/coc.nvim";
    #      flake = false;
    #    };

    # learning vim

    "plugin:vim-be-good" = {
      url = "github:ThePrimeagen/vim-be-good";
      flake = false;
    };
    "plugin:nerdtree" = {
      url = "github:preservim/nerdtree";
      flake = false;
    };
    # Terminal
    "plugin:toggleterm" = {
      url = "github:akinsho/toggleterm.nvim";
      flake = false;
    };
    # note taking
    "plugin:vimwiki" = {
      url = "github:vimwiki/vimwiki";
      flake = false;
    };
    # Git
    "plugin:gitsigns" = {
      url = "github:lewis6991/gitsigns.nvim";
      flake = false;
    };
    "plugin:fugitive" = {
      url = "github:tpope/vim-fugitive";
      flake = false;
    };

    "plugin:vim-surround" = {
      url = "github:tpope/vim-surround";
      flake = false;
    };
    # telescope 
    "plugin:telescope-plugin" = {
      url = "github:nvim-telescope/telescope-project.nvim";
      flake = false;
    };
    "plugin:telescope-plugin-vimwiki" = {
      url = "github:ElPiloto/telescope-vimwiki.nvim";
      flake = false;
    };

    "plugin:webdev-icons" = {
      url = "github:nvim-tree/nvim-web-devicons";
      flake = false;
    };

    "plugin:vim-commentary" = {
      url = "github:tpope/vim-commentary";
      flake = false;
    };
    "plugin:tagbar" = {
      url = "github:preservim/tagbar";
      flake = false;
    };
    "plugin:js-is-bad" = {
      url = "github:pangloss/vim-javascript";
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
    "plugin:go.nvim" = {
      url = "github:ray-x/go.nvim";
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
      url = "github:NeogitOrg/neogit";
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
        wrapLuaConfig = luaConfig: ''
          lua << EOF
          ${luaConfig}
          EOF
        '';


        vimFile = path: "${builtins.readFile path}";
        luaFile = path: wrapLuaConfig "${builtins.readFile path}";
        #stringToList = str: builtins.split "\n" str;
        #getRequire = s: builtins.match "require ([^\n]+).*" s;
        #getPath = input: builtins.substring (builtins.stringLength "require ") (builtins.stringLength input) input;
        #parseLuaFile = path: parseLua "${builtins.readFile path}";


        pluginOverlay = final: prev:
          let
            inherit (prev.vimUtils) buildVimPluginFrom2Nix;
            treesitterGrammars =
              prev.tree-sitter.withPlugins (_: [ prev.tree-sitter.allGrammars ]);
            plugins =
              builtins.filter (s: (builtins.match "plugin:.*" s) != null)
                (builtins.attrNames inputs);
            plugName = input:
              builtins.substring (builtins.stringLength "plugin:")
                (builtins.stringLength input)
                input;
            buildPlug = name:
              buildVimPluginFrom2Nix {
                pname = plugName name;
                version = "master";
                src = builtins.getAttr name inputs;
              };
          in
          {
            neovimPlugins = builtins.listToAttrs (map
              (plugin: {
                name = plugName plugin;
                value = buildPlug plugin;
              })
              plugins);
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
        # customLuaRc | your init.lua as string
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
        neovimBuilder =
          { luaConfigRC ? ""
          , customRC ? ""
          , viAlias ? true
          , vimAlias ? true
          , start ? builtins.attrValues pkgs.neovimPlugins
          , opt ? [ ]
          , debug ? false
          }:
          let
            myNeovimUnwrapped = pkgs.neovim-unwrapped.overrideAttrs (prev: {
              propagatedBuildInputs = with pkgs; [ pkgs.stdenv.cc.cc.lib ];
            });
          in
          pkgs.wrapNeovim myNeovimUnwrapped {
            inherit viAlias;
            inherit vimAlias;
            configure = {
              customRC = ''
                ${wrapLuaConfig luaConfigRC}
                ${customRC}
              '';
              packages.myVimPackage = with pkgs.neovimPlugins; {
                start = start;
                opt = opt;
              };
            };
          };
      in
      rec {
        overlay = final: prev: {
          neovim = self.packages.neovimGlenda;
          neovimGlenda = self.packages.neovimGlenda;
        };

        nixosModules.default = { config, lib, pkgs, ... }:

          with lib;
          let cfg = config.neovim-flake.neovim;
          in
          {
            options.neovim-flake.neovim = {
              enable = mkEnableOption "Enables neovim";
            };

            config = mkIf cfg.enable {
              environment.systemPackages =
                [ self.packages.${system}.neovimGlenda ];
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
            # ${luaFile ./config/lua/config/coc.lua}
            customRC = ''
              ${luaFile ./config/lua/config/markdown.lua}
              ${luaFile ./config/lua/config/neorg.lua}
              ${luaFile ./config/lua/config/theme.lua}
              ${luaFile ./config/lua/config/mkdnflow.lua}
              ${luaFile ./config/lua/config/vimwiki.lua}
              ${vimFile ./config/toggleterm.vim}
              ${luaFile ./config/lua/config/options.lua}
              ${luaFile ./config/lua/config/toggleterm.lua}
              ${luaFile ./config/lua/config/colorsheme.lua}
              ${luaFile ./config/lua/config/whichkey.lua}
              ${luaFile ./config/lua/config/comment.lua}
              ${luaFile ./config/lua/config/autopairs.lua}
              ${luaFile ./config/lua/config/lualine.lua}
              ${luaFile ./config/lua/config/dashboard.lua}
              ${luaFile ./config/lua/config/telescope.lua}
              ${luaFile ./config/lua/config/keymap.lua}
              ${luaFile ./config/lua/config/git.lua}
              ${luaFile ./config/lua/config/cmp.lua}
              ${luaFile ./config/lua/config/lsp/fmt.lua}
              ${luaFile ./config/lua/config/lsp/nix.lua}
              ${luaFile ./config/lua/config/lsp/gopls.lua}
              ${luaFile ./config/lua/config/lsp/rust.lua}
              ${luaFile ./config/lua/config/rust.lua}
              ${luaFile ./config/lua/config/easyread.lua}
              autocmd BufWritePre <buffer> lua vim.lsp.buf.format()
            '';
            # ${luaFile ./config/lua/config/lsp/lua.lua}

          };
        };
      });
}
