{ pkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/75f4ba05c63be3f147bcc2f7bd4ba1f029cedcb1.tar.gz") { } }:

pkgs.mkShell {
    buildInputs = [
     	pkgs.jdk
	pkgs.apache-jena
	pkgs.python
	pkgs.openssl
    ];
}
