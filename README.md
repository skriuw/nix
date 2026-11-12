# Skriuw for Nix

A Nix flake for [Skriuw](https://skriuw.com), a quiet writing workspace for notes,
journaling, sharing, and planning. It packages the released `.deb` for `x86_64-linux`.

## Run

```bash
nix run github:skriuw/nix
```

## Install

Add the flake as an input and use the overlay or the package directly:

```nix
{
  inputs.skriuw.url = "github:skriuw/nix";

  outputs = { nixpkgs, skriuw, ... }: {
    nixosConfigurations.host = nixpkgs.lib.nixosSystem {
      modules = [
        ({ pkgs, ... }: {
          environment.systemPackages = [ skriuw.packages.${pkgs.system}.default ];
        })
      ];
    };
  };
}
```

`release.json` is rewritten for every Skriuw release by the release workflow in
[remcostoeten/skriuw](https://github.com/remcostoeten/skriuw). Do not edit it by hand.

<br />

xxx
Remco Stoeten

<small>MIT</small>
