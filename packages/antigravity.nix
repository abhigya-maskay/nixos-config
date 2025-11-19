{ pkgs, lib, ... }:

pkgs.stdenv.mkDerivation rec {
  pname = "antigravity";
  version = "1.11.2";

  src = pkgs.fetchurl {
    url = "https://edgedl.me.gvt1.com/edgedl/release2/j0qc3/antigravity/stable/1.11.2-6251250307170304/linux-x64/Antigravity.tar.gz";
    sha256 = "1dv4bx598nshjsq0d8nnf8zfn86wsbjf2q56dqvmq9vcwxd13cfi";
  };

  nativeBuildInputs = [
    pkgs.makeWrapper
    pkgs.copyDesktopItems
    pkgs.autoPatchelfHook
  ];

  buildInputs = with pkgs; [
    alsa-lib
    at-spi2-atk
    at-spi2-core
    atk
    cairo
    cups
    dbus
    expat
    fontconfig
    freetype
    gdk-pixbuf
    glib
    gtk3
    libdrm
    libnotify
    libuuid
    xorg.libX11
    xorg.libXcomposite
    xorg.libXcursor
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXi
    xorg.libXrandr
    xorg.libXrender
    xorg.libXScrnSaver
    xorg.libXtst
    xorg.libxcb
    xorg.libxkbfile
    mesa
    nspr
    nss
    pango
    systemd
    udev
    zlib
    libglvnd
    gsettings-desktop-schemas
  ];

  installPhase = ''
    mkdir -p $out/share/antigravity
    cp -r * $out/share/antigravity
    
    mkdir -p $out/bin
    ln -s $out/share/antigravity/bin/antigravity $out/bin/antigravity

    wrapProgram $out/bin/antigravity \
      --prefix XDG_DATA_DIRS : "${pkgs.gsettings-desktop-schemas}/share/gsettings-schemas/${pkgs.gsettings-desktop-schemas.name}:${pkgs.gtk3}/share/gsettings-schemas/${pkgs.gtk3.name}:$XDG_DATA_DIRS"
  '';

  desktopItems = [
    (pkgs.makeDesktopItem {
      name = "antigravity";
      desktopName = "Google Antigravity";
      genericName = "Integrated Development Environment";
      exec = "antigravity %F";
      icon = "antigravity"; # Assuming icon is available or generic
      comment = "Google's new AI-first IDE";
      categories = [ "Development" "IDE" ];
    })
  ];

  meta = with lib; {
    description = "Google Antigravity IDE";
    homepage = "https://antigravity.google.com"; # Assumption
    license = licenses.unfree;
    platforms = platforms.linux;
    mainProgram = "antigravity";
  };
}
