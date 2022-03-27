with (import <nixpkgs> { config = {}; overlays = []; });

{
    exampleDeps = haskell.packages.ghc8107.ghcWithPackages (p: with p; [
        base
        zlib
        ]);
}
