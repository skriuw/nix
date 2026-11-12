{
  description = "Skriuw, a quiet writing workspace for notes, journaling, sharing, and planning";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs =
    { self, nixpkgs }:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
      packages.${system} = {
        skriuw = pkgs.callPackage ./package.nix { };
        default = self.packages.${system}.skriuw;
      };

      apps.${system}.default = {
        type = "app";
        program = "${self.packages.${system}.skriuw}/bin/skriuw-app";
      };

      overlays.default = final: _prev: {
        skriuw = final.callPackage ./package.nix { };
      };
    };
}
