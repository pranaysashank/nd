with (import <nixpkgs> { config = {}; overlays = []; });

{
    ndDeps = haskell.packages.ghc8107.ghcWithPackages (p: with p; [
        aeson
        base
        parsec
        ]);
}
