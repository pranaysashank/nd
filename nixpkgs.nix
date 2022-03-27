let
  nixpkgs = builtins.fetchTarball {
    # commit from March 2022, branch: nixpkgs-unstable
    url =
      "https://github.com/NixOS/nixpkgs/archive/3eb07eeafb52bcbf02ce800f032f18d666a9498d.tar.gz";
    sha256 = "1ah1fvll0z3w5ykzc6pabqr7mpbnbl1i3vhmns6k67a4y7w0ihrr";
  };

in
import nixpkgs
