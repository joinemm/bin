# `bin`

This is a collection of bash scripts I've written over the years for various purposes.

## Usage on standard distros

You can find the scripts in `./src`.

## Usage with Nix

Nix flake is included, which exposes some of the scripts as nix packages. (Many of them have no use on NixOS but are here for legacy reasons)

The built derivations include all of their dependencies in the wrapper path, so all scripts can be used as a self contained program.

You have two options: you can either install these scripts into your system path, or run them from github with `nix run`.

### Install

In your system `flake.nix` import the flake as an input:

```nix
{
  # ...
  inputs = {
    bin.url = "github:joinemm/bin";
    ... # your other inputs
  };
}
```

The script packages are exposed under `inputs.bin.packages.${system}`, and available for most systems (but only `x86-64_linux` is actually tested)

You can install the scripts you need like any other package:

```nix
{
  environment.systemPackages = [
    inputs.bin.packages.${system}.color
  ];
}
```

After this, the script is in your path and you can simply run it like any other program:

```sh
\$ color
```

### Run without installing

```sh
\$ nix run github:joinemm/bin#color
```
