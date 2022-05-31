{ pkgs, inputs, ... }: {
  imports = [
    ./alacritty.nix
    ./qutebrowser.nix
    ./xsession.nix
    ./theme.nix
    ./dunst.nix
    ./zathura.nix
  ];
  home.packages = with pkgs; [
    libreoffice
    hsetroot
    qbittorrent
    python39Packages.ueberzug
    ytfzf
    maim
    xdotool
    zoom-us
    brave
    xclip
    xsel
    dmenu
    authy
    webcamoid
    mpv
    keepassxc
    mcomix3
  ];
}
