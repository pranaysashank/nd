# Give your project a name. :)
workspace(name = "com_example")

# Load the repository rule to download an http archive.
load(
    "@bazel_tools//tools/build_defs/repo:http.bzl",
    "http_archive",
)

# Download rules_haskell and make it accessible as "@rules_haskell".
http_archive(
    name = "rules_haskell",
    sha256 = "851e16edc7c33b977649d66f2f587071dde178a6e5bcfeca5fe9ebbe81924334",
    strip_prefix = "rules_haskell-0.14",
    urls = ["https://github.com/tweag/rules_haskell/archive/v0.14.tar.gz"],
)

load(
    "@rules_haskell//haskell:repositories.bzl",
    "rules_haskell_dependencies",
)

# Setup all Bazel dependencies required by rules_haskell.
rules_haskell_dependencies()

# Load nixpkgs_git_repository from rules_nixpkgs,
# which was already initialized by rules_haskell_dependencies above.
load(
    "@io_tweag_rules_nixpkgs//nixpkgs:nixpkgs.bzl",
    "nixpkgs_cc_configure",
    "nixpkgs_local_repository",
    "nixpkgs_package",
    "nixpkgs_python_configure",
)

nixpkgs_local_repository(
    name = "nixpkgs",
    nix_file = "//:nixpkgs.nix",
)

nixpkgs_cc_configure(
    repository = "@nixpkgs",
)

nixpkgs_python_configure(
    repository = "@nixpkgs",
)

load(
    "@rules_haskell//haskell:nixpkgs.bzl",
    "haskell_register_ghc_nixpkgs",
)

# Fetch a GHC binary distribution from nixpkgs and register it as a toolchain.
# For more information:
# https://api.haskell.build/haskell/nixpkgs.html#haskell_register_ghc_nixpkgs
haskell_register_ghc_nixpkgs(
    attribute_path = "exampleDeps",
    nix_file = "//:ghc.nix",
    repository = "@nixpkgs",
    version = "8.10.7",
)

http_archive(
    name = "io_bazel_rules_docker",
    sha256 = "85ffff62a4c22a74dbd98d05da6cf40f497344b3dbf1e1ab0a37ab2a1a6ca014",
    strip_prefix = "rules_docker-0.23.0",
    urls = ["https://github.com/bazelbuild/rules_docker/releases/download/v0.23.0/rules_docker-v0.23.0.tar.gz"],
)

# load("@io_bazel_rules_docker//toolchains/docker:toolchain.bzl", docker_toolchain_configure = "toolchain_configure")

# docker_toolchain_configure(
#     name = "docker_config",
#     docker_path = "/usr/bin/docker",
# )

load("@io_bazel_rules_docker//container:container.bzl", "container_load")
load("@io_bazel_rules_docker//repositories:repositories.bzl", container_repositories = "repositories")

container_repositories()

load("@io_bazel_rules_docker//repositories:deps.bzl", container_deps = "deps")

container_deps()

nixpkgs_package(
    name = "raw-haskell-base-image",
    build_file_content = """
package(default_visibility = [ "//visibility:public" ])
exports_files(["image"])
    """,
    # See below for how to define this
    nix_file = "//:haskellBaseImageDocker.nix",
    repository = "@nixpkgs",
)

container_load(
    name = "haskell-base-image",
    file = "@raw-haskell-base-image//:image",
)
