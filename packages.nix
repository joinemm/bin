{
  perSystem =
    { pkgs, lib, ... }:
    let
      bashDeps = rec {
        myip = with pkgs; [ wget2 ];

        vpn = with pkgs; [ systemd ];

        screencast = with pkgs; [
          slop
          ffmpeg-full
        ];

        kobo = with pkgs; [
          fd
          rsync
          kepubify
        ];

        add-torrent = with pkgs; [
          libnotify
          transmission_4
        ];

        tailscale-menu = with pkgs; [
          rofi
          curl
          jq
          tailscale
        ];

        lock = with pkgs; [ xsecurelock ];

        power-menu =
          (with pkgs; [
            rofi
            systemd
          ])
          ++ lock;

        vk_radv_nixos = [ ];

        setbg = with pkgs; [ feh ];

        color = with pkgs; [
          xcolor
          xclip
          libnotify
        ];

        buds = with pkgs; [ bluez ];

        dock = with pkgs; [ mons ];

        audio-control = with pkgs; [
          pulseaudio
          procps
          gnugrep
          gawk
        ];

        extract = with pkgs; [
          gnutar # tar
          xz # unlzma, unxz
          bzip2 # bunzip2
          unar # .rar
          gzip # gunzip, uncompress
          p7zip # .7z
          cabextract # cabextract
          unzip
          gnused
          zstd
        ];
      };
    in
    {
      packages = lib.attrsets.mapAttrs (
        name: path:
        pkgs.writeShellApplication {
          name = "${name}";
          runtimeInputs = path;
          text = (builtins.readFile ./src/${name});
        }
      ) bashDeps;
    };
}
