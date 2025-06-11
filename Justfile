up:
  nix flake update
gc:
  sudo nix-collect-garbage --delete-old
deploy:
  sudo nixos-rebuild switch
