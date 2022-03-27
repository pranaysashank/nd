# nixpkgs is provisioned by rules_nixpkgs for us which we set to be ./nixpkgs.nix
with import <nixpkgs> { system = "x86_64-linux"; };

# Build the base image.
# The output of this derivation will be a Docker archive in the same format as
# the output of `docker save` that we can feed to
# [container_load](https://github.com/bazelbuild/rules_docker#container_load)
let
  haskellBase = dockerTools.buildLayeredImage {
    name = "haskell-base-image-unwrapped";
    created = "now";
    contents = [ glibc libffi gmp zlib iana-etc cacert ]; # Here we can specify nix-provisioned libraries our haskell_binary products may need at runtime
  };
  # rules_nixpkgs require the nix output to be a directory,
  # so we create one in which we put the image we've just created
in runCommand "haskell-base-image" { } ''
  mkdir -p $out
  gunzip -c ${haskellBase} > $out/image
''
