{ system, nixpkgs, haskell-nix, nix-tools, foliage }: 
let 
  compiler-nix-name = "ghc8107";
  pkgs = import nixpkgs { inherit system; inherit (haskell-nix) config; overlays = [haskell-nix.overlay]; };
  foliagePrj = pkgs.haskell-nix.cabalProject {
    inherit compiler-nix-name;
    src = foliage;
  };
  # We want to patch the hackage-db used by nix-tools, which unfortunately 
  # requires us to replicate a lot of complicated setup, copied from haskell.nix...
  nixToolsPrj = pkgs.haskell-nix.cabalProject {
    inherit compiler-nix-name;
    src = nix-tools;
    cabalProjectLocal = ''
      source-repository-package
        type: git
        location: https://github.com/michaelpj/hackage-db.git
        tag: f3b9240212b036391871e4ea09891e91efcea7a1
        --sha256: sha256-n0ATmkwtR68E2FuZK3QIQgZirVmWbd21vIQmzhGKsRw=
      constraints: Cabal >= 3.4
    '';
    modules = [{
      packages.transformers-compat.components.library.doExactConfig = true;
      packages.time-compat.components.library.doExactConfig = true;
      packages.time-locale-compat.components.library.doExactConfig = true;
      # Make Cabal reinstallable
      nonReinstallablePkgs =
        [ "rts" "ghc-heap" "ghc-prim" "integer-gmp" "integer-simple" "base"
          "deepseq" "array" "ghc-boot-th" "pretty" "template-haskell"
          "ghc-boot"
          "ghc" "Win32" "array" "binary" "bytestring" "containers"
          "directory" "filepath" "ghc-boot" "ghc-compact" "ghc-prim"
          "hpc"
          "mtl" "parsec" "process" "text" "time" "transformers"
          "unix" "xhtml"
        ];
    }];
  };
in rec {
  hackage-to-nix = nixToolsPrj.nix-tools.components.exes.hackage-to-nix;
  foliage = foliagePrj.foliage.components.exes.foliage;
  buildRepository = pkgs.writeShellScriptBin "buildRepository" ''
    echo "Running foliage, taking source from $INPUT, outputting to $OUTPUT, keys from $KEYS"
    ${foliage}/bin/foliage build --input-directory $INPUT --output-directory $OUTPUT --keys $KEYS
    echo "Running hackage-to-nix, using url $REPOSITORY_URL"
    ${hackage-to-nix}/bin/hackage-to-nix $OUTPUT $OUTPUT/01-index.tar $REPOSITORY_URL
  '';
}
