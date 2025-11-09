up:
  nix flake update
gc:
  sudo nix-collect-garbage --delete-old
deploy:
  sudo install -d -m755 /var/cache/nix-build
  sudo nixos-rebuild --option build-dir /var/cache/nix-build switch
