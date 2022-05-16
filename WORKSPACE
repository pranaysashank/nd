# Give your project a name. :)
workspace(name = "nd")

# Load the repository rule to download an http archive.
load(
    "@bazel_tools//tools/build_defs/repo:http.bzl",
    "http_archive",
)

http_archive(
    name = "io_tweag_rules_nixpkgs",
    sha256 = "d3e2d0fb83906666d657762ef2d11ec61a8cb2213ade34c2d80915b91969f6ab",
    strip_prefix = "rules_nixpkgs-aeeabeea6e655bf254c6c9133a1a91ad8a83157b",
    urls = ["https://github.com/tweag/rules_nixpkgs/archive/aeeabeea6e655bf254c6c9133a1a91ad8a83157b.tar.gz"],
)

http_archive(
    name = "build_bazel_rules_nodejs",
    sha256 = "3ceb1e5b5dcad5fa2ad8870a20201cfbb9c9c63cac4055c9ab370034c765297f",
    urls = ["https://github.com/bazelbuild/rules_nodejs/releases/download/5.3.0/rules_nodejs-5.3.0.tar.gz"],
)

http_archive(
    name = "io_bazel_rules_go",
    sha256 = "2b1641428dff9018f9e85c0384f03ec6c10660d935b750e3fa1492a281a53b0f",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/rules_go/releases/download/v0.29.0/rules_go-v0.29.0.zip",
        "https://github.com/bazelbuild/rules_go/releases/download/v0.29.0/rules_go-v0.29.0.zip",
    ],
)

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "59536e6ae64359b716ba9c46c39183403b01eabfbd57578e84398b4829ca499a",
    strip_prefix = "rules_docker-0.22.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.22.0/rules_docker-v0.22.0.tar.gz"],
)

http_archive(
    name = "bazel_gazelle",
    sha256 = "de69a09dc70417580aabf20a28619bb3ef60d038470c7cf8442fafcf627c21cb",
    urls = [
        "https://mirror.bazel.build/github.com/bazelbuild/bazel-gazelle/releases/download/v0.24.0/bazel-gazelle-v0.24.0.tar.gz",
        "https://github.com/bazelbuild/bazel-gazelle/releases/download/v0.24.0/bazel-gazelle-v0.24.0.tar.gz",
    ],
)

# http_archive(
#     name = "io_tweag_gazelle_haskell_modules",
#     # sha256 = "ba866d66bee40f0f29115529ee68b0c58105ee9cf9178f9b865652979fe256d8",
#     sha256 = "cdc6a17f9fbe829cc33e7b993d8aeb9146408a579adb6e9e6ac6c907f4d72d9b",
#     strip_prefix = "gazelle_haskell_modules-1b5cf1ad0a8262f550f25a7286fb9ce1b02817ac",
#     url = "https://github.com/tweag/gazelle_haskell_modules/archive/1b5cf1ad0a8262f550f25a7286fb9ce1b02817ac.zip",
# )

local_repository(
    name = "io_tweag_gazelle_haskell_modules",
    path = "../../tweag/gazelle_haskell_modules",
)

# Download rules_haskell and make it accessible as "@rules_haskell".
#http_archive(
#    name = "rules_haskell",
#    sha256 = "7da035221d5500c8fb7ec3dbadb460e330fa9ab0be7f94894429a92ea68e0d4f",
#    strip_prefix = "rules_haskell-a20de0b8437448a86c784b64332a49e9c1a0cd90",
#    urls = ["https://github.com/tweag/rules_haskell/archive/a20de0b8437448a86c784b64332a49e9c1a0cd90.tar.gz"],
#)

local_repository(
    name = "rules_haskell",
    path = "../../tweag/rules_haskell",
)

load("@io_tweag_rules_nixpkgs//nixpkgs:repositories.bzl", "rules_nixpkgs_dependencies")

rules_nixpkgs_dependencies()

# Load nixpkgs_git_repository from rules_nixpkgs,
# which was already initialized by rules_haskell_dependencies above.
load(
    "@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl",
    "nixpkgs_cc_configure",
    "nixpkgs_local_repository",
    "nixpkgs_python_configure"
)

nixpkgs_local_repository(
    name = "nixpkgs",
    nix_file = "//:nixpkgs.nix",
    nix_file_deps =
        [
            "//:ghc.nix",
        ],
)

nixpkgs_cc_configure(
    repository = "@nixpkgs",
)

nixpkgs_python_configure(
    repository = "@nixpkgs",
)

###############
# Go preamble
###############

load("@io_tweag_rules_nixpkgs//nixpkgs:toolchains/go.bzl", "nixpkgs_go_configure")

nixpkgs_go_configure(
    repository = "@nixpkgs",
)

load("@io_bazel_rules_go//go:deps.bzl", "go_rules_dependencies")

go_rules_dependencies()

##################
# Gazelle preamble
##################

load("@bazel_gazelle//:deps.bzl", "gazelle_dependencies")

gazelle_dependencies()

########################
# rules_haskell preamble
########################

load(
    "@rules_haskell//haskell:repositories.bzl",
    "rules_haskell_dependencies",
)

# Setup all Bazel dependencies required by rules_haskell.
rules_haskell_dependencies()

load(
    "@rules_haskell//haskell:nixpkgs.bzl",
    "haskell_register_ghc_nixpkgs",
)

# Fetch a GHC binary distribution from nixpkgs and register it as a toolchain.
# For more information:
# https://api.haskell.build/haskell/nixpkgs.html#haskell_register_ghc_nixpkgs
# haskell_register_ghc_nixpkgs(
#     repository = "@nixpkgs",
#     attribute_path = "haskell.packages.ghc8107",
#     version = "8.10.7",
# )
haskell_register_ghc_nixpkgs(
    attribute_path = "ndDeps",
    nix_file = "//:ghc.nix",
    repository = "@nixpkgs",
    version = "8.10.7",
)

load("@io_tweag_gazelle_haskell_modules//:defs.bzl", "gazelle_haskell_modules_dependencies")

gazelle_haskell_modules_dependencies(
    aeson = "@nd//package-a:aeson",
    parsec = "@nd//package-a:parsec",
)
