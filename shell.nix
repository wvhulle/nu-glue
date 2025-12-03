{
  pkgs ? import <nixpkgs> { },
}:

let
  nu-lint = pkgs.callPackage (pkgs.fetchFromGitHub {
    owner = "wvhulle";
    repo = "nu-lint";
    rev = "9f067df19b2afb081f79085bb47a0569f7aceceb";
    sha256 = "sha256-qmmR9N8e3G32gfLvQq8p09ECaPFF9mBBzcrQoRbh20E=";
  }) { };

  topiary-nu-module = pkgs.fetchFromGitHub {
    owner = "blindfs";
    repo = "topiary-nushell";
    rev = "fd78be393af5a64e56b493f52e4a9ad1482c07f4";
    sha256 = "sha256-5gmLFnbHbQHnE+s1uAhFkUrhEvUWB/hg3/8HSYC9L14=";
  };
in
pkgs.mkShell {
  buildInputs = with pkgs; [
    nushell
    tinymist
    unzip
    nu-lint
    topiary
  ];

  TOPIARY_CONFIG_FILE = ".topiary/languages.ncl";
  TOPIARY_LANGUAGE_DIR = ".topiary/languages";

  shellHook = ''
    nu ./setup-topiary.nu ${topiary-nu-module}
  '';
}
