{ system, nixpkgs, haskell-nix, nix-tools, foliage }: 
let 
  compiler-nix-name = "ghc8107";
  pkgs = import nixpkgs { inherit system; inherit (haskell-nix) config; overlays = [haskell-nix.overlay]; };
  foliagePrj = pkgs.haskell-nix.cabalProject {
    inherit compiler-nix-name;
    src = foliage;
  };
in rec {
  foliage = foliagePrj.foliage.components.exes.foliage;
  buildRepository = pkgs.writeShellScriptBin "buildRepository" ''
    echo "Running foliage, taking source from $INPUT, outputting to $OUTPUT, keys from $KEYS"
    ${foliage}/bin/foliage build --input-directory $INPUT --output-directory $OUTPUT --keys $KEYS
  '';
}
