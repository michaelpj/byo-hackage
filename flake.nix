{
  description = "byo-hackage";

  inputs = {
		nixpkgs.follows = "haskell-nix/nixpkgs-unstable";
    hackage-nix = {
      url = "github:input-output-hk/hackage.nix";
      flake = false;
    };
    nix-tools = {
      url = "github:input-output-hk/nix-tools";
      flake = false;
    };
    haskell-nix = {
      url = "github:input-output-hk/haskell.nix?rev=9987a666f2fba42c330cb6ad35d7deb102264d9a";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.hackage.follows = "hackage-nix";
      inputs.nix-tools.follows = "nix-tools";
    };
    foliage = {
      url = "github:andreabedini/foliage";
      flake = false;
    };
    flake-utils.url = "github:numtide/flake-utils"; 
  };

  outputs = { self , nixpkgs , haskell-nix , nix-tools, flake-utils, foliage, ... }: 
    let 
     system = "x86_64-linux";
     outs = import ./default.nix { inherit system nixpkgs haskell-nix nix-tools foliage; };
    in { packages.${system} = outs; };
}
