# `bin`

This is a collection of bash scripts I've written over the years for various purposes.

You can find the scripts in `./src`.

Nix flake with [Resholve](https://github.com/abathur/resholve) dependency solver is provided, including most of the scripts as packages.

The built derivations include any dependencies to other commands in the wrapper, so all scripts can be used as a self contained program.

## Usage with nix

You have two options: you can either install these scripts to use them whenever, or run them temporarily with nix.

### Install

In `flake.nix` import the flake as an input:

```nix
{
  # ...
  inputs.bin = {
    url = "github:joinemm/bin";
    # may break if your version of nixpkgs differs too much from the one in this repo
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

then you can install scripts like any other package:

```nix
{
  environment.systemPackages = [
    inputs.packages.${system}.color
  ];
}
```

### Run

```sh
nix run github:joinemm/bin#color
```
