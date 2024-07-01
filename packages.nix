{pkgs, ...}: rec {
  lock = pkgs.resholve.writeScriptBin "lock" {
    inputs = with pkgs; [
      xsecurelock
    ];
    interpreter = "/bin/sh";
  } (builtins.readFile ./src/lock);

  vk_radv_nixos = pkgs.resholve.writeScriptBin "vk_radv_nixos" {
    inputs = [];
    interpreter = "${pkgs.bash}/bin/bash";
  } (builtins.readFile ./src/vk_radv_nixos);

  setbg = pkgs.resholve.writeScriptBin "setbg" {
    inputs = with pkgs; [
      coreutils
      feh
    ];
    execer = [
      "cannot:${pkgs.feh}/bin/feh"
    ];
    interpreter = "/bin/sh";
  } (builtins.readFile ./src/setbg);

  color = pkgs.resholve.writeScriptBin "color" {
    inputs = with pkgs; [
      coreutils
      xcolor
      xclip
      libnotify
    ];
    interpreter = "/bin/sh";
  } (builtins.readFile ./src/color);

  buds = pkgs.resholve.writeScriptBin "buds" {
    inputs = with pkgs; [
      bluez
    ];
    interpreter = "/bin/sh";
  } (builtins.readFile ./src/buds);

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
  } (builtins.readFile ./src/dock);

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
      "cannot:${pkgs.pulseaudio}/bin/pactl"
    ];
    interpreter = "/bin/sh";
  } (builtins.readFile ./src/audio-control);

  extract = pkgs.resholve.writeScriptBin "extract" {
    inputs = with pkgs; [
      coreutils
      gnutar # tar
      xz # unlzma, unxz
      bzip2 # bunzip2
      unar # .rar
      gzip # gunzip, uncompress
      p7zip # .7z
      cabextract # cabextract
      unzip
      gnused
    ];
    execer = [
      "cannot:${pkgs.p7zip}/bin/7z"
      "cannot:${pkgs.gzip}/bin/uncompress"
      "cannot:${pkgs.gzip}/bin/gunzip"
    ];
    interpreter = "/bin/sh";
  } (builtins.readFile ./src/extract);

  power-menu = pkgs.resholve.writeScriptBin "power-menu" {
    inputs = with pkgs; [
      rofi
      systemd
      lock
    ];
    execer = [
      "cannot:${pkgs.rofi}/bin/rofi"
      "cannot:${pkgs.systemd}/bin/poweroff"
      "cannot:${pkgs.systemd}/bin/reboot"
    ];
    interpreter = "/bin/sh";
  } (builtins.readFile ./src/power-menu);

  add-torrent = pkgs.resholve.writeScriptBin "add-torrent" {
    inputs = with pkgs; [
      libnotify
      transmission_4
    ];
    execer = [
      "cannot:${pkgs.transmission_4}/bin/transmission-remote"
    ];
    interpreter = "/bin/sh";
  } (builtins.readFile ./src/add-torrent);

  kobo = pkgs.resholve.writeScriptBin "kobo" {
    inputs = with pkgs; [
      fd
      rsync
      kepubify
    ];
    execer = [
      "cannot:${pkgs.fd}/bin/fd"
      "cannot:${pkgs.kepubify}/bin/kepubify"
      "cannot:${pkgs.rsync}/bin/rsync"
    ];
    fake = {
      external = ["sudo"];
    };
    interpreter = "/bin/sh";
  } (builtins.readFile ./src/kobo);
}
