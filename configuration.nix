# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, inputs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./fonts.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelPackages = pkgs.linuxPackages;
  # Ensure NVIDIA DRM KMS and disable fbdev to reduce KMS glitches
  boot.kernelParams = [
    "nvidia-drm.modeset=1"
    "nvidia-drm.fbdev=0"
  ];

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager = {
    enable = true;
    # Use default wpa_supplicant backend; switch to "iwd" if desired.
    # wifi.backend = "iwd";
    wifi.powersave = false; # disable Wi‑Fi power saving to avoid idle dropouts
    dns = "systemd-resolved";
    ensureProfiles = {
      environmentFiles = [ "/etc/nixos/secrets/nm-asus-pd-5g.env" ];
      profiles.Asus_pd_5G = {
        connection = {
          id = "Asus_pd_5G";
          type = "wifi";
          permissions = "";
        };
        wifi = {
          ssid = "Asus_pd_5G";
          mode = "infrastructure";
        };
        wifi-security = {
          key-mgmt = "wpa-psk";
          psk = "$NM_WIFI_ASUS_PD_5G_PSK";
        };
        ipv4.method = "auto";
        ipv6.method = "auto";
      };
    };
  };

  # Use NetworkManager for DHCP/DNS; disable global DHCP setting.
  networking.useDHCP = false;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  # networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "America/Chicago";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };


  # For automatic disk mounting
  services.udisks2.enable = true;

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.ave70011 = {
    isNormalUser = true;
    description = "Abhigya Maskay";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" "input" "docker" "storage"];
    shell = pkgs.zsh;
  };

  # Install firefox.
  programs.zsh.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Steam Configuration
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };

  # Gaming performance
  programs.gamemode.enable = true;

  # Tailscale VPN
  services.tailscale.enable = true;

  services.greetd = {
    enable = true;
    restart = false;
    settings = {
      # Auto-start X11 session for ave70011; fallback to greeter if it exits
      initial_session = {
        command = "${pkgs.xorg.xinit}/bin/startx";
        user = "ave70011";
      };
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd startx";
        user = "greeter";
      };
    };
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    tree
    just
    docker
    docker-compose
    iw
    linuxHeaders
    evtest
    lxqt.lxqt-openssh-askpass
    xorg.xinit
  ];


  # Enable flakes and adjust build settings
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    cores = 12;
    max-jobs = 2;
    build-dir = "/var/cache/nix-build";
  };

  systemd.tmpfiles.rules = [
    "d /var/cache/nix-build 0755 root root -"
  ];

  environment.variables = {
    EDITOR = "nvim";
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  environment.sessionVariables = {
    SUDO_ASKPASS = "${pkgs.lxqt.lxqt-openssh-askpass}/bin/lxqt-openssh-askpass";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver = {
    enable = true;
    videoDrivers = [ "nvidia" ];
    displayManager.startx.enable = true;
  };
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    # Use long-lived/production NVIDIA driver branch for stability
    package = config.boot.kernelPackages.nvidiaPackages.production;
    nvidiaPersistenced = true;
    forceFullCompositionPipeline = true;
  };
  # Keep NVIDIA device state across client exits (configured in hardware.nvidia block above)
  hardware.cpu.amd.updateMicrocode = true;
  hardware.xpadneo.enable = true;

  # Talon Voice - Tobii eye tracker udev rules
  services.udev.extraRules = ''
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2104", ATTRS{idProduct}=="0127", GROUP="plugdev", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2104", ATTRS{idProduct}=="0118", GROUP="plugdev", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2104", ATTRS{idProduct}=="0106", GROUP="plugdev", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2104", ATTRS{idProduct}=="0128", GROUP="plugdev", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2104", ATTRS{idProduct}=="010a", GROUP="plugdev", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2104", ATTRS{idProduct}=="0102", GROUP="plugdev", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2104", ATTRS{idProduct}=="0313", GROUP="plugdev", TAG+="uaccess"
    SUBSYSTEM=="usb", ATTRS{idVendor}=="2104", ATTRS{idProduct}=="0318", GROUP="plugdev", TAG+="uaccess"

    # Vial keyboard configurator
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
  '';

  powerManagement.enable = false;
  
  # Disable WiFi power management to prevent disconnections
  networking.extraHosts = ''
    127.0.0.1 localhost
  '';
  
  # systemd-resolved for robust DNS (integrates with NetworkManager and Tailscale)
  services.resolved.enable = true;

  virtualisation.docker.enable = true;

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?

}
