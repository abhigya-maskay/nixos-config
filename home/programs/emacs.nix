{config, lib, pkgs, inputs, ... }:

let  
    envExtra = lib.mkAfter ''
      export PATH="${config.xdg.configHome}/emacs/bin:$PATH"
    '';

    shellAliases = {
      codex = "codex --search";
      e = "emacsclient --create-frame";
      et = "emacsclient --create-frame --tty";
    };

    myEmacsPackagesFor = emacs: ((pkgs.emacsPackagesFor emacs).emacsWithPackages (epkgs: [
      epkgs.vterm
    ]));

    emacsPkg = myEmacsPackagesFor pkgs.emacs-pgtk;
in {
    programs.bash.bashrcExtra = envExtra;
    programs.zsh.envExtra = envExtra;
    home.shellAliases = shellAliases;

    xdg.configFile."doom".source = inputs.doom-config;

    home.activation.installDoomEmacs = lib.hm.dag.entryAfter["writeBoundary"] ''
      ${pkgs.rsync}/bin/rsync -avz --chmod=D2755,F744 ${inputs.doomemacs}/ ${config.xdg.configHome}/emacs/
    '';

    home.packages = with pkgs; [
      emacs-pgtk
      direnv
      graphviz
    ];

    services.emacs = {
      enable = true;
      package = emacsPkg;
      client = {
        enable = true;
        arguments = [" --create-frame"];
      };
      startWithUserSession = true;
    };
  }
