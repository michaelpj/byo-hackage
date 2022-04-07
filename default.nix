{ system, nixpkgs, haskellNix, foliage }: 
let pkgs = import nixpkgs { inherit system; inherit (haskellNix) config; overlays = [haskellNix.overlay]; };
in {
  nix-tools = pkgs.haskell-nix.internal-nix-tools; 
  foliage = pkgs.haskell-nix.cabalProject {
    src = foliage;
  }
}
