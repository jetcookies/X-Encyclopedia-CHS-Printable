{
  lib,
  stdenvNoCC,
  fetchurl,
  p7zip,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "sarasa-gothic-ui-sc";
  version = "1.0.33";

  src = fetchurl {
    # Use the 'ttc' files here for a smaller closure size.
    # (Using 'ttf' files gives a closure size about 15x larger, as of November 2021.)
    url = "https://github.com/be5invis/Sarasa-Gothic/releases/download/v${finalAttrs.version}/SarasaUiSC-TTF-${finalAttrs.version}.7z";
    hash = "sha256-2OT2xqTY4Xm2BYTsQihUYt2fxW4LtZD9GHjrTGNM8oE=";
  };

  sourceRoot = ".";

  nativeBuildInputs = [ p7zip ];

  installPhase = ''
    runHook preInstall

    mkdir -p $out/share/fonts/truetype
    cp *.ttf $out/share/fonts/truetype

    runHook postInstall
  '';

  meta = {
    description = "CJK programming font based on Iosevka and Source Han Sans";
    homepage = "https://github.com/be5invis/Sarasa-Gothic";
    license = lib.licenses.ofl;
    maintainers = with lib.maintainers; [
      ChengCat
      wegank
    ];
    platforms = lib.platforms.all;
  };
})
