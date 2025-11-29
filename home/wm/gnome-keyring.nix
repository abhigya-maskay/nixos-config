{ pkgs, ... }:

{
  # gnome-keyring is started by PAM via services.gnome.gnome-keyring
  # Just need libsecret for secret-tool and client libraries
  home.packages = [ pkgs.libsecret ];
}
