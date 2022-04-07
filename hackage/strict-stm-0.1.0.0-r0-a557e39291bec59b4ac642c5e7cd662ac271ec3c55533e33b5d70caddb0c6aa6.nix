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
    flags = { checktvarinvariant = false; asserts = false; };
    package = {
      specVersion = "1.10";
      identifier = { name = "strict-stm"; version = "0.1.0.0"; };
      license = "Apache-2.0";
      copyright = "2019-2021 Input Output (Hong Kong) Ltd.";
      maintainer = "";
      author = "Alexander Vieth, Marcin Szamotulski, Duncan Coutts";
      homepage = "";
      url = "";
      synopsis = "Strict STM interface polymorphic over stm implementation.";
      description = "The `strict-stm` package gives a strict interface to stm,\ncurrently either one provided by `stm` package for the\n`IO` monad or `io-sim` package for the `IOSim` monad.";
      buildType = "Simple";
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."stm" or (errorHandler.buildDepError "stm"))
          (hsPkgs."io-classes" or (errorHandler.buildDepError "io-classes"))
          ];
        buildable = true;
        };
      };
    } // {
    src = (pkgs.lib).mkDefault (pkgs.fetchurl {
      url = "https://michaelpj.github.io/byo-hackage/package/strict-stm-0.1.0.0.tar.gz";
      sha256 = config.sha256;
      });
    }