{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  buildInputs = with pkgs; [
    cmark
    gomplate
    htmlq
    bats
    minify
    jq
    (pkgs.writeShellScriptBin "parallel-moreutils" ''${pkgs.moreutils}/bin/parallel "$@"'')
    (pkgs.writeShellScriptBin "serve" ''${pkgs.python3}/bin/python3 -m http.server'')
  ];

  MIME_TYPES_PATH = "${pkgs.mailcap}/etc/mailcap";
  PROJECT_ROOT = "${builtins.toString ./.}";

  shellHook = ''
    PATH="${builtins.toString ./.}/tools:$PATH"
  '';
}
