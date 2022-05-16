let
  nixpkgs = builtins.fetchTarball {
    # commit from April 2022, branch: nixpkgs-unstable
    url =
      "https://github.com/NixOS/nixpkgs/archive/faad370edcb37162401be50d45526f52bb16a713.tar.gz";
    sha256 = "sha256:1d82d4vh0layf6n925j0h2nym16jbvcvps3l5m8ln9hxn0m6gadn";
  };

in 
_ : import nixpkgs {}
