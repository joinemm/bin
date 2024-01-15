{
  description = "Shell scripts collection";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = {
    self,
    nixpkgs,
    flake-utils,
  }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = nixpkgs.legacyPackages.${system};

      lock = pkgs.resholve.writeScriptBin "lock" {
        inputs = with pkgs; [
          xsecurelock
        ];
        interpreter = "/bin/sh";
      } (builtins.readFile ./lock);

      vk_radv_nixos = pkgs.resholve.writeScriptBin "vk_radv_nixos" {
        inputs = [];
        interpreter = "${pkgs.bash}/bin/bash";
      } (builtins.readFile ./vk_radv_nixos);

      setbg = pkgs.resholve.writeScriptBin "setbg" {
        inputs = with pkgs; [
          coreutils
          feh
        ];
        execer = [
          "cannot:${pkgs.feh}/bin/feh"
        ];
        interpreter = "/bin/sh";
      } (builtins.readFile ./setbg);

      color = pkgs.resholve.writeScriptBin "color" {
        inputs = with pkgs; [
          coreutils
          xcolor
          xclip
          libnotify
        ];
        interpreter = "/bin/sh";
      } (builtins.readFile ./color);

      buds = pkgs.resholve.writeScriptBin "buds" {
        inputs = with pkgs; [
          bluez
        ];
        interpreter = "/bin/sh";
      } (builtins.readFile ./buds);

      dock = pkgs.resholve.writeScriptBin "dock" {
        inputs = with pkgs; [
          mons
        ];
        keep = {
          "~/.fehbg" = true;
        };
        execer = [
          "cannot:${pkgs.mons}/bin/mons"
        ];
        interpreter = "${pkgs.bash}/bin/bash";
      } (builtins.readFile ./dock);

      audio-control = pkgs.resholve.writeScriptBin "audio-control" {
        inputs = with pkgs; [
          coreutils
          pulseaudio
          procps
          gnugrep
          gawk
        ];
        execer = [
          "cannot:${pkgs.procps}/bin/pkill"
        ];
        interpreter = "/bin/sh";
      } (builtins.readFile ./audio-control);

      extract = pkgs.resholve.writeScriptBin "extract" {
        inputs = with pkgs; [
          coreutils
          gnutar # tar
          xz # unlzma, unxz
          bzip2 # bunzip2
          unrar-wrapper # unrar
          gzip # gunzip, uncompress
          p7zip # 7z
          cabextract # cabextract
          unzip
          gnused
        ];
        execer = [
          "cannot:${pkgs.p7zip}/bin/7z"
          "cannot:${pkgs.unrar-wrapper}/bin/unrar"
          "cannot:${pkgs.gzip}/bin/uncompress"
          "cannot:${pkgs.gzip}/bin/gunzip"
        ];
        interpreter = "/bin/sh";
      } (builtins.readFile ./extract);

      power-menu = pkgs.resholve.writeScriptBin "power-menu" {
        inputs = with pkgs; [
          rofi
          systemd
          lock
        ];
        execer = [
          "cannot:${pkgs.rofi}/bin/rofi"
        ];
        interpreter = "/bin/sh";
      } (builtins.readFile ./power-menu);

      add-torrent = pkgs.resholve.writeScriptBin "add-torrent" {
        inputs = with pkgs; [
          libnotify
          transmission
        ];
        execer = [
          "cannot:${pkgs.transmission}/bin/transmission-remote"
        ];
        interpreter = "/bin/sh";
      } (builtins.readFile ./add-torrent);
    in {
      packages = {
        inherit
          color
          buds
          dock
          audio-control
          extract
          lock
          power-menu
          setbg
          vk_radv_nixos
          add-torrent
          ;
      };
    });
}
