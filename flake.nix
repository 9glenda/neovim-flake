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
    "plugin:webdev-icons" = {
      url = "github:nvim-tree/nvim-web-devicons";
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
    wrapLuaConfig = luaConfig: ''
    lua << EOF
    ${luaConfig}
    EOF
  '';

  luaFile = path: wrapLuaConfig "${builtins.readFile path}";

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
        neovimBuilder = { luaConfigRC ? "", customRC ? "", viAlias ? true, vimAlias ? true
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
      in rec {
        overlays.default = final: prev: {
          neovim = self.packages.neovimGlenda;
        };

        nixosModules.default = { config, lib, pkgs, ... }:

          with lib;
          let cfg = config.neovim-flake.neovim;
          in {
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
            # the next line loads a trivial example of a init.vim:
            # customRC = pkgs.lib.readFile ./${packages.config}/bin/init.vim;
          #customRC = luaFile ./config/lua/config/options.lua;

          customRC =''
${luaFile ./config/lua/config/options.lua}
${luaFile ./config/lua/config/colorsheme.lua}
${luaFile ./config/lua/config/whichkey.lua}
${luaFile ./config/lua/config/cmp.lua}
${luaFile ./config/lua/config/comment.lua}
${luaFile ./config/lua/config/autopairs.lua}
${luaFile ./config/lua/config/lualine.lua}
${luaFile ./config/lua/config/dashboard.lua}
${luaFile ./config/lua/config/telescope.lua}
${luaFile ./config/lua/config/keymap.lua}
${luaFile ./config/lua/config/git.lua}
${luaFile ./config/lua/config/lsp/nix.lua}
${luaFile ./config/lua/config/lsp/gopls.lua}
${luaFile ./config/lua/config/lsp/lua.lua}
${luaFile ./config/lua/config/lsp/rust.lua}
            '';

# -- ${luaFile ./config/lua/config/lsp.lua}
#            luaConfigRC = ''
#
#local options = {
#  backup = false,                          -- creates a backup file
#  clipboard = "unnamedplus",               -- allows neovim to access the system clipboard
#  cmdheight = 2,                           -- more space in the neovim command line for displaying messages
#  completeopt = { "menuone", "noselect" }, -- mostly just for cmp
#  conceallevel = 0,                        -- so that `` is visible in markdown files
#  fileencoding = "utf-8",                  -- the encoding written to a file
#  hlsearch = true,                         -- highlight all matches on previous search pattern
#  ignorecase = true,                       -- ignore case in search patterns
#  mouse = "a",                             -- allow the mouse to be used in neovim
#  pumheight = 10,                          -- pop up menu height
#  showmode = false,                        -- we don't need to see things like -- INSERT -- anymore
#  showtabline = 2,                         -- always show tabs
#  smartcase = true,                        -- smart case
#  smartindent = true,                      -- make indenting smarter again
#  splitbelow = true,                       -- force all horizontal splits to go below current window
#  splitright = true,                       -- force all vertical splits to go to the right of current window
#  swapfile = false,                        -- creates a swapfile
#  -- termguicolors = true,                    -- set term gui colors (most terminals support this)
#  timeoutlen = 300,                        -- time to wait for a mapped sequence to complete (in milliseconds)
#  undofile = true,                         -- enable persistent undo
#  updatetime = 300,                        -- faster completion (4000ms default)
#  writebackup = false,                     -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
#  expandtab = true,                        -- convert tabs to spaces
#  shiftwidth = 2,                          -- the number of spaces inserted for each indentation
#  tabstop = 2,                             -- insert 2 spaces for a tab
#  cursorline = true,                       -- highlight the current line
#  number = true,                           -- set numbered lines
#  relativenumber = true,                   -- set relative numbered lines
#  numberwidth = 4,                         -- set number column width to 2 {default 4}
#
#  signcolumn = "yes",                      -- always show the sign column, otherwise it would shift the text each time
#  wrap = false,                            -- display lines as one long line
#  linebreak = false,                        -- companion to wrap, don't split words
#  scrolloff = 8,                           -- minimal number of screen lines to keep above and below the cursor
#  sidescrolloff = 8,                       -- minimal number of screen columns either side of cursor if wrap is `false`
#  guifont = "monospace:h12",               -- the font used in graphical neovim applications
#}
#
#vim.opt.shortmess:append "c"
#
#for k, v in pairs(options) do
#  vim.opt[k] = v
#end
#
#vim.cmd "set whichwrap+=<,>,[,],h,l"
#vim.cmd [[set iskeyword+=-]]
#vim.cmd [[set formatoptions-=cro]] -- TODO: this doesn't seem to work
#            '';
            #customRC = "
            #luafile ${packages.config}/bin/init.lua
            #";
            # if you wish to only load the onedark-vim colorscheme:
            # start = with pkgs.neovimPlugins; [ onedark-vim neovim-tree ];
          };
          config = pkgs.stdenv.mkDerivation {
            name = "config";
            src = ./.;
            buildPhase = ''
            '';
            installPhase = ''
              printf 'require "%s/bin/config/lua/config/options.lua"' "$out" > init.lua
              mkdir -p $out/bin
              cp -r config $out/bin
              cp init.vim $out/bin
              cp init.lua $out/bin
            '';
          };
          runNeovim = pkgs.stdenv.mkDerivation {
            name = "runNeovim";
            src = ./.;
            buildPhase = ''
              printf '#!/bin/sh
              LUA_PATH=%s:$LUA_PATH ${packages.neovimGlenda}/bin/nvim' "$out/bin/config" > runNeovim
              '';
            installPhase = ''
              mkdir -p $out/bin
              install runNeovim $out/bin/runNeovim
            '';
          };
        };
      });
}
