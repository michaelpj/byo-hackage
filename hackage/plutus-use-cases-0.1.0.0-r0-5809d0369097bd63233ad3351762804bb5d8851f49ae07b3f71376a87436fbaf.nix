{ system
  , compiler
  , flags
  , pkgs
  , hsPkgs
  , pkgconfPkgs
  , errorHandler
  , config
  , ... }:
  {
    flags = { defer-plugin-errors = false; };
    package = {
      specVersion = "2.0";
      identifier = { name = "plutus-use-cases"; version = "0.1.0.0"; };
      license = "Apache-2.0";
      copyright = "";
      maintainer = "jann.mueller@iohk.io";
      author = "Manuel M T Chakravarty, Jann Müller";
      homepage = "";
      url = "";
      synopsis = "Collection of smart contracts to develop the plutus/wallet interface";
      description = "Collection of smart contracts to develop the plutus/wallet interface.";
      buildType = "Simple";
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."aeson" or (errorHandler.buildDepError "aeson"))
          (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
          (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
          (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
          (hsPkgs."plutus-core" or (errorHandler.buildDepError "plutus-core"))
          (hsPkgs."plutus-tx" or (errorHandler.buildDepError "plutus-tx"))
          (hsPkgs."plutus-contract" or (errorHandler.buildDepError "plutus-contract"))
          (hsPkgs."playground-common" or (errorHandler.buildDepError "playground-common"))
          (hsPkgs."plutus-ledger" or (errorHandler.buildDepError "plutus-ledger"))
          (hsPkgs."plutus-ledger-api" or (errorHandler.buildDepError "plutus-ledger-api"))
          (hsPkgs."plutus-ledger-constraints" or (errorHandler.buildDepError "plutus-ledger-constraints"))
          (hsPkgs."template-haskell" or (errorHandler.buildDepError "template-haskell"))
          (hsPkgs."lens" or (errorHandler.buildDepError "lens"))
          (hsPkgs."text" or (errorHandler.buildDepError "text"))
          (hsPkgs."prettyprinter" or (errorHandler.buildDepError "prettyprinter"))
          (hsPkgs."hashable" or (errorHandler.buildDepError "hashable"))
          (hsPkgs."freer-simple" or (errorHandler.buildDepError "freer-simple"))
          (hsPkgs."streaming" or (errorHandler.buildDepError "streaming"))
          (hsPkgs."semigroups" or (errorHandler.buildDepError "semigroups"))
          (hsPkgs."openapi3" or (errorHandler.buildDepError "openapi3"))
          ] ++ (pkgs.lib).optional (!(compiler.isGhcjs && true || system.isGhcjs)) (hsPkgs."plutus-tx-plugin" or (errorHandler.buildDepError "plutus-tx-plugin"));
        buildable = true;
        };
      exes = {
        "plutus-use-cases-scripts" = {
          depends = [
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."cardano-crypto-class" or (errorHandler.buildDepError "cardano-crypto-class"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."data-default" or (errorHandler.buildDepError "data-default"))
            (hsPkgs."freer-extras" or (errorHandler.buildDepError "freer-extras"))
            (hsPkgs."prettyprinter" or (errorHandler.buildDepError "prettyprinter"))
            (hsPkgs."QuickCheck" or (errorHandler.buildDepError "QuickCheck"))
            (hsPkgs."tasty" or (errorHandler.buildDepError "tasty"))
            (hsPkgs."tasty-hunit" or (errorHandler.buildDepError "tasty-hunit"))
            (hsPkgs."tasty-golden" or (errorHandler.buildDepError "tasty-golden"))
            (hsPkgs."tasty-quickcheck" or (errorHandler.buildDepError "tasty-quickcheck"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            (hsPkgs."lens" or (errorHandler.buildDepError "lens"))
            (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
            (hsPkgs."freer-simple" or (errorHandler.buildDepError "freer-simple"))
            (hsPkgs."foldl" or (errorHandler.buildDepError "foldl"))
            (hsPkgs."streaming" or (errorHandler.buildDepError "streaming"))
            (hsPkgs."plutus-ledger-api" or (errorHandler.buildDepError "plutus-ledger-api"))
            (hsPkgs."plutus-tx" or (errorHandler.buildDepError "plutus-tx"))
            (hsPkgs."plutus-contract" or (errorHandler.buildDepError "plutus-contract"))
            (hsPkgs."plutus-ledger" or (errorHandler.buildDepError "plutus-ledger"))
            (hsPkgs."plutus-ledger-constraints" or (errorHandler.buildDepError "plutus-ledger-constraints"))
            (hsPkgs."plutus-use-cases" or (errorHandler.buildDepError "plutus-use-cases"))
            (hsPkgs."optparse-applicative" or (errorHandler.buildDepError "optparse-applicative"))
            (hsPkgs."cardano-api" or (errorHandler.buildDepError "cardano-api"))
            ] ++ (pkgs.lib).optional (!(compiler.isGhcjs && true || system.isGhcjs)) (hsPkgs."plutus-tx-plugin" or (errorHandler.buildDepError "plutus-tx-plugin"));
          buildable = true;
          };
        };
      tests = {
        "plutus-use-cases-test" = {
          depends = [
            (hsPkgs."plutus-tx" or (errorHandler.buildDepError "plutus-tx"))
            (hsPkgs."plutus-contract" or (errorHandler.buildDepError "plutus-contract"))
            (hsPkgs."plutus-ledger" or (errorHandler.buildDepError "plutus-ledger"))
            (hsPkgs."plutus-ledger-constraints" or (errorHandler.buildDepError "plutus-ledger-constraints"))
            (hsPkgs."plutus-use-cases" or (errorHandler.buildDepError "plutus-use-cases"))
            (hsPkgs."base" or (errorHandler.buildDepError "base"))
            (hsPkgs."bytestring" or (errorHandler.buildDepError "bytestring"))
            (hsPkgs."cardano-crypto-class" or (errorHandler.buildDepError "cardano-crypto-class"))
            (hsPkgs."containers" or (errorHandler.buildDepError "containers"))
            (hsPkgs."data-default" or (errorHandler.buildDepError "data-default"))
            (hsPkgs."freer-extras" or (errorHandler.buildDepError "freer-extras"))
            (hsPkgs."prettyprinter" or (errorHandler.buildDepError "prettyprinter"))
            (hsPkgs."tasty" or (errorHandler.buildDepError "tasty"))
            (hsPkgs."tasty-hunit" or (errorHandler.buildDepError "tasty-hunit"))
            (hsPkgs."tasty-hedgehog" or (errorHandler.buildDepError "tasty-hedgehog"))
            (hsPkgs."tasty-golden" or (errorHandler.buildDepError "tasty-golden"))
            (hsPkgs."tasty-quickcheck" or (errorHandler.buildDepError "tasty-quickcheck"))
            (hsPkgs."text" or (errorHandler.buildDepError "text"))
            (hsPkgs."lens" or (errorHandler.buildDepError "lens"))
            (hsPkgs."mtl" or (errorHandler.buildDepError "mtl"))
            (hsPkgs."QuickCheck" or (errorHandler.buildDepError "QuickCheck"))
            (hsPkgs."freer-simple" or (errorHandler.buildDepError "freer-simple"))
            (hsPkgs."foldl" or (errorHandler.buildDepError "foldl"))
            (hsPkgs."streaming" or (errorHandler.buildDepError "streaming"))
            ] ++ (pkgs.lib).optional (!(compiler.isGhcjs && true || system.isGhcjs)) (hsPkgs."plutus-tx-plugin" or (errorHandler.buildDepError "plutus-tx-plugin"));
          buildable = true;
          };
        };
      };
    } // {
    src = (pkgs.lib).mkDefault (pkgs.fetchurl {
      url = "https://michaelpj.github.io/byo-hackage/package/plutus-use-cases-0.1.0.0.tar.gz";
      sha256 = config.sha256;
      });
    }