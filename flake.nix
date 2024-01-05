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

      fehbg = pkgs.resholve.writeScriptBin "fehbg" {
        inputs = with pkgs; [
          feh
        ];
        execer = [
          "cannot:${pkgs.feh}/bin/feh"
        ];
        interpreter = "/bin/sh";
      } (builtins.readFile ./fehbg);

      buds = pkgs.resholve.writeScriptBin "buds" {
        inputs = with pkgs; [
          bluez
        ];
        interpreter = "/bin/sh";
      } (builtins.readFile ./buds);

      dock = pkgs.resholve.writeScriptBin "dock" {
        inputs = with pkgs; [
          mons
          fehbg
        ];
        interpreter = "/bin/sh";
      } (builtins.readFile ./dock);

      audio-control = pkgs.resholve.writeScriptBin "audio-control" {
        inputs = with pkgs; [
          coreutils
          pulseaudio
        ];
        interpreter = "/bin/sh";
      } (builtins.readFile ./audio-control);

      extract = pkgs.resholve.writeScriptBin "extract" {
        inputs = with pkgs; [
          gnutar # tar
          xz # unlzma, unxz
          bzip2 # bunzip2
          unrar-wrapper # unrar
          gzip # gunzip, uncompress
          p7zip # 7z
          cabextract # cabextract
        ];
        interpreter = "/bin/sh";
      } (builtins.readFile ./extract);
    };
  };
}
