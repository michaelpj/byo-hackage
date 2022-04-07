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
    flags = {};
    package = {
      specVersion = "1.10";
      identifier = { name = "typed-protocols"; version = "0.1.0.0"; };
      license = "Apache-2.0";
      copyright = "2019 Input Output (Hong Kong) Ltd.";
      maintainer = "alex@well-typed.com, duncan@well-typed.com, marcin.szamotulski@iohk.io";
      author = "Alexander Vieth, Duncan Coutts, Marcin Szamotulski";
      homepage = "";
      url = "";
      synopsis = "A framework for strongly typed protocols";
      description = "";
      buildType = "Simple";
      };
    components = {
      "library" = {
        depends = [
          (hsPkgs."base" or (errorHandler.buildDepError "base"))
          (hsPkgs."io-classes" or (errorHandler.buildDepError "io-classes"))
          ];
        buildable = true;
        };
      };
    } // {
    src = (pkgs.lib).mkDefault (pkgs.fetchurl {
      url = "https://michaelpj.github.io/byo-hackage/package/typed-protocols-0.1.0.0.tar.gz";
      sha256 = config.sha256;
      });
    }