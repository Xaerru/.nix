{ pkgs, inputs, ... }:

with inputs.nix-colors.lib { inherit pkgs; };

let 
colors = inputs.nix-colors.colorSchemes.default-dark.colors;
in rec {
  imports = [./services/tor.nix];
  home = {
    username = "xaerru";
    homeDirectory = "/home/xaerru";
    stateVersion = "22.05";
  };

  programs.home-manager.enable = true;

  programs.bash.enable = true;
  services.tor.enable = true;
  services.gpg-agent = {
    enable = true;
    enableSshSupport = true;
    pinentryFlavor = "gtk2";
    defaultCacheTtl = 34560000;
    defaultCacheTtlSsh = 34560000;
    maxCacheTtl = 34560000;
    maxCacheTtlSsh = 34560000;
    sshKeys = [ "13E0B25F8DF3A7D0DAB55F4290D620BE5F61B7CF" ];
    extraConfig = ''
      allow-preset-passphrase
    '';
  };
  home.packages = with pkgs; [
    keepassxc
    aria
    testdisk
    unzip
    qbittorrent
    torsocks
    tor
    weechat
    ffmpeg
    python39Packages.ueberzug
    ytfzf
    maim
    xdotool
    playerctl
    taskwarrior
    nixfmt
    python3
    ghc
    dwm
    fzf
    zoom-us
    brave
    exa
    fd
    xclip
    cmake
    ninja
    dmenu
    neovim
    mpv
    firefox
    youtube-dl
  ];
  programs.alacritty = {
    enable = true;
    settings = {
      colors = {
        primary = {
          background = "#${colors.base00}";
          foreground = "#${colors.base05}";
        };
        cursor = {
          text = "#${colors.base00}";
          cursor = "#${colors.base05}";
        };
        normal = {
          black = "#${colors.base00}";
          red = "#${colors.base08}";
          green = "#${colors.base0B}";
          yellow = "#${colors.base0A}";
          blue = "#${colors.base0D}";
          magenta = "#${colors.base0E}";
          cyan = "#${colors.base0C}";
          white = "#${colors.base05}";
        };
        bright = {
          black = "#${colors.base03}";
          red = "#${colors.base08}";
          green = "#${colors.base0B}";
          yellow = "#${colors.base0A}";
          blue = "#${colors.base0D}";
          magenta = "#${colors.base0E}";
          cyan = "#${colors.base0C}";
          white = "#${colors.base07}";
        };
        indexed_colors = [
          {
            index = 16;
            color = "#${colors.base09}";
          }
          {
            index = 17;
            color = "#${colors.base0F}";
          }
          {
            index = 18;
            color = "#${colors.base01}";
          }
          {
            index = 19;
            color = "#${colors.base02}";
          }
          {
            index = 20;
            color = "#${colors.base04}";
          }
          {
            index = 21;
            color = "#${colors.base06}";
          }
        ];
      };
      env = { TERM = "xterm-256color"; };
      font = { size = 8; };
      selection.save_to_clipboard = true;
      window = {
        decorations = "full";
        padding = {
          x = 5;
          y = 5;
        };
      };
    };
  };
  programs.qutebrowser = {
    enable = true;
    settings = {
      colors.webpage.preferred_color_scheme = "dark";
      colors.webpage.darkmode.enabled = true;
    };
    extraConfig = builtins.readFile (builtins.fetchurl {
      url =
        "https://raw.githubusercontent.com/theova/base16-qutebrowser/e47e7e03ccb8909a4751d3507cc3c3ad243f13c0/themes/minimal/base16-default-dark.config.py";
      sha256 = "169ybhn0cl9fqhfxgs3srdqxia6lhvvbmqlcd7bpjdnyj3v5jn7q";
    });
  };
  programs.tmux = {
    enable = true;
    clock24 = true;
    plugins = with pkgs.tmuxPlugins; [ sensible pain-control fzf-tmux-url ];
    extraConfig = builtins.readFile ./config/tmux.conf;
  };
  programs.ssh = {
    enable = true;
    extraConfig = builtins.readFile ./config/ssh/config;
  };
  programs.gpg = {
    enable = true;
    settings.use-agent = false;
  };
  programs.git = {
    enable = true;
    userName = "Gauravsingh Sisodia";
    userEmail = "xaerru@disroot.org";
    signing = {
      signByDefault = true;
      key = "68831668597E023C!";
    };
    extraConfig = { init = { defaultBranch = "main"; }; };
    lfs = { enable = true; };
  };
  programs.lazygit = {
     enable = true;
     settings = {
       git = {
          autoFetch = false;
       };
       gui = {
         showRandomTip = false;
	 authorColors = {
           "Gauravsingh Sisodia" = "#7cafc2";
	 };
       };
       keybindings = {
         universal = {appendNewLine = "<tab>";};
       };
     };
  };
  xsession = {
     windowManager.xmonad = {
        enable = true;
	enableContribAndExtras = true;
	config = ./config/xmonad/xmonad.hs;
     };
  };
  gtk = {
     enable = true;
     theme = {
      name = "default-dark";
      package = gtkThemeFromScheme { scheme = inputs.nix-colors.colorSchemes.default-dark; };
    };
  };
  qt = {
     enable = true;
     platformTheme = "gtk";
  };
  services.xsettingsd = {
    enable = true;
    settings = {
      "Net/ThemeName" = "${gtk.theme.name}";
    };
  };
}
