{
  pkgs ? import <nixpkgs> { },
}:

pkgs.mkShell {

  buildInputs = [
    pkgs.nushell
    pkgs.unzip
  ];

  shellHook = "nu";

}
