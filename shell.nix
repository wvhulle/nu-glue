{
  pkgs ? import <nixpkgs> { },
}:

let
  # Import nu-lint
  nu-lint = pkgs.callPackage (pkgs.fetchFromGitHub {
    owner = "wvhulle";
    repo = "nu-lint";
    rev = "0c41873c81260e2dca74a19f8df9d821545369ca";
    sha256 = "sha256-l4ylLUbqqWDRdY8fDaUulK5FfVqhRVaMPb8dcQLppxE=";
  }) { };

  # Topiary nushell support
  topiary-nu-module = pkgs.fetchFromGitHub {
    owner = "blindfs";
    repo = "topiary-nushell";
    rev = "fd78be393af5a64e56b493f52e4a9ad1482c07f4";
    sha256 = "sha256-5gmLFnbHbQHnE+s1uAhFkUrhEvUWB/hg3/8HSYC9L14=";
  };

in
pkgs.mkShell {

  buildInputs = [
    pkgs.nushell
    pkgs.unzip
    nu-lint
    pkgs.topiary
  ];

  shellHook = ''
    # Set up topiary configuration locally in the project
    mkdir -p .topiary/languages

    # Set environment variables for topiary
    export TOPIARY_CONFIG_FILE="$(pwd)/.topiary/languages.ncl"
    export TOPIARY_LANGUAGE_DIR="$(pwd)/.topiary/languages"

    # Copy the nushell query file if it doesn't exist or is different
    if [[ ! -f .topiary/languages/nu.scm ]] || ! cmp -s ${topiary-nu-module}/languages/nu.scm .topiary/languages/nu.scm; then
      cp ${topiary-nu-module}/languages/nu.scm .topiary/languages/
      chmod 644 .topiary/languages/nu.scm
    fi

    # Create basic topiary config if it doesn't exist
    if [[ ! -f .topiary/languages.ncl ]]; then
      cat > .topiary/languages.ncl << 'EOF'
{
  languages = {
    nu = {
      extensions = ["nu"],
      grammar.source.git = {
        git = "https://github.com/nushell/tree-sitter-nu.git",
        rev = "18b7f951e0c511f854685dfcc9f6a34981101dd6",
      },
    },
  },
}
EOF
    fi

    echo "nix-shell ready with nu-lint and topiary (nushell support)"
  '';

}
