{ lib, stdenv, fetchFromGitHub, rustPlatform, Security, installShellFiles }:

rustPlatform.buildRustPackage rec {
  pname = "ferium";
  version = "4.1.11";

  src = fetchFromGitHub {
    owner = "gorilla-devs";
    repo = pname;
    rev = "v${version}";
    sha256 = "sha256-CqErnyBoGC+jTN1wNzKsjuAmfuwZ0NzZKyqdP2hPKUM=";
  };

  buildInputs = lib.optionals stdenv.isDarwin [ Security ];

  cargoSha256 = "sha256-2IEIIO4Gi9nyf0FoTiqGuA/ebE15sIFjeFqlETARaJY=";

  # Disable the GUI file picker so that GTK/XDG dependencies aren't used
  buildNoDefaultFeatures = true;

  # Requires an internet connection
  doCheck = false;

  nativeBuildInputs = [ installShellFiles ];

  postInstall = ''
    for shell in bash fish zsh; do
      $out/bin/ferium complete $shell > ferium.$shell
      installShellCompletion ferium.$shell
    done
  '';

  meta = with lib; {
    description = "Fast and multi-source CLI program for managing Minecraft mods and modpacks from Modrinth, CurseForge, and GitHub Releases";
    homepage = "https://github.com/gorilla-devs/ferium";
    license = licenses.mpl20;
    maintainers = with maintainers; [ leo60228 imsofi ];
  };
}
