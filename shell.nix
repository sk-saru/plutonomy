{withTex ? false}: let
  pkgs = import ( # nixpkgs 22.05
    builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/ce6aa13369b667ac2542593170993504932eb836.tar.gz"
  ) {};
in
  pkgs.mkShell {
    name = "plutonomy";

    buildInputs = with pkgs;
      [
        libsodium
        pkgconfig
        secp256k1
        zlib
      ]
      ++ (with haskell.packages.ghc8107; [
        cabal-install
        ghc
        haskell-language-server
      ])
      ++ lib.optional withTex (pkgs.texlive.combine {inherit (pkgs.texlive) scheme-basic latexmk;});

  }
