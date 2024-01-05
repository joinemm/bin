{
  description = "Shell scripts collection";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = {
    self,
    nixpkgs,
  }: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    packages.${system} = {
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
    };
  };
}
