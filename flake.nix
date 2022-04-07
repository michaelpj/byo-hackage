{
  description = "byo-hackage";

  inputs = {
		nixpkgs.follows = "haskellNix/nixpkgs-unstable";
    hackageNix = {
      url = "github:input-output-hk/hackage.nix";
      flake = false;
    };
    nixTools = {
      url = "github:input-output-hk/nix-tools";
      flake = false;
    };
    haskellNix = {
      url = "github:input-output-hk/haskell.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      #inputs.hackage.follows = "hackageNix";
      inputs.hackage.follows = "nixTools";
    };
    inputs.flake-utils.url = "github:numtide/flake-utils"; 
    foliage = {
      url = "github:andreabedini/foliage";
      flake = false;
    };
  };

  outputs = { self , nixpkgs , haskellNix , flake-utils, foliage }: 
    flake-utils.lib.eachSystem [ "x86_64-linux" "x86_64-darwin" ] (system: 
       import ./default.nix { inherit system nixpkgs haskellNix foliage; }
    )
}
