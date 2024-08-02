# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
    ./hardware.nix
  ];

  # Use the systemd-boot EFI boot loader.
  #boot.loader.systemd-boot.enable = true;
  #boot.loader.efi.canTouchEfiVariables = true;

  #Bootloader
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "nodev";
  boot.loader.grub.efiSupport = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # boot.loader.grub.catppuccin.enable = true;
  #  boot.loader.grub.useOSProber = true;
  boot.loader.efi.efiSysMountPoint = "/boot";

  networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "America/Bogota";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  #Firewall
  # networking.firewall = {
  #   enable = true;
  #   allowedTCPPorts = [3000];
  #   allowedUDPPorts = [];
  # };

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  console = {
    font = "Lat2-Terminus16";
    #keyMap = "la-latin1";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.videoDrivers = ["amdgpu"];
  services.libinput.enable = true;
  services.xserver.windowManager.i3.enable = true;

  # Configure keymap in X11
  services.xserver.xkb.layout = "latam";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  #Wayland Support
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };

  # services.displayManager.sddm.package = pkgs.kdePackages.sddm;
  services.displayManager.sddm.enable = true;
  # services.displayManager.sddm.catppuccin.assertQt6Sddm = true;
  services.displayManager.sddm.wayland.enable = true;
  # services.displayManager.sddm.catppuccin.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound.
  # sound.enable = true;
  hardware.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  #Nix flakes
  nix.settings.experimental-features = ["nix-command" "flakes"];

  # Environment variables
  environment.sessionVariables = rec {
    XDG_CACHE_HOME = "$HOME/.cache";
    XDG_CONFIG_HOME = "$HOME/.config";
    XDG_DATA_HOME = "$HOME/.local/share";
    XDG_STATE_HOME = "$HOME/.local/state";

    # Not officially in the specification
    XDG_BIN_HOME = "$HOME/.local/bin";
    PATH = [
      "${XDG_BIN_HOME}"
    ];

    # XDG environment variables
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_TYPE = "wayland";
    XDG_SESSION_DESKTOP = "Hyprland";

    # GDK environment variables
    GDK_BACKEND = "wayland,x11";

    # QT environment variables
    QT_QPA_PLATFORM = "wayland";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";
    QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
    QT_AUTO_SCREEN_SCALE_FACTOR = "1";

    # SDL environment variable
    SDL_VIDEODRIVER = "wayland";

    # Other environment variables
    _JAVA_AWT_WM_NONREPARENTING = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    MOZ_DISABLE_RDD_SANDBOX = "1";
    MOZ_ENABLE_WAYLAND = "1";
    OZONE_PLATFORM = "wayland";

    #GTK
    # GTK_THEME = "Catppuccin-Dark-Macchiato-BL-MB:dark";
  };

  #Style
  # catppuccin.enable = true;
  # stylix.targets.chromium.enable = false;
  # stylix.targets.grub.enable = false;

  nixpkgs.config.allowUnfree = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.estebandev = {
    isNormalUser = true;
    description = "Esteban Gonzalez Florez";
    extraGroups = ["wheel" "docker"]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    zip
    unzip
    unar
    bash
    gcc
    cargo
    wget
    neovim
    git
    wayland
    killall
    starship
    wl-clipboard
    flameshot
    unzip
    dunst
    adwaita-icon-theme
    lsd
    bat
    socat
    python3
    docker_27
    steam
    fnm
    jdk17
    # wineWowPackages.minimal
    #wineWowPackages.full
    vmware-workstation
    linuxKernel.packages.linux_6_6.vmware
    run
    wineWowPackages.stable
    bottles-unwrapped
    protonup-qt
    libGL
    file
    mtpfs
    simple-mtpfs

    #Audio
    alsa-lib
    alsa-utils
    alsa-tools

    #Hypr
    hyprland
    hyprpaper
    hyprpicker
    hyprlock
    hypridle
    hyprcursor
    libnotify
    slurp
    grim
    wayland-scanner

    #Fish
    fish
    fzf
    grc
  ];

  programs.nix-ld.enable = true;
  programs.nix-ld.package = pkgs.nix-ld-rs;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    xorg.libXcomposite
    xorg.libXtst
    xorg.libXrandr
    # ... (other libraries)
  ];

  # The module in this repository defines a new module under (programs.nix-ld.dev) instead of (programs.nix-ld)
  # to not collide with the nixpkgs version.
  #programs.nix-ld.dev.enable = true;

  # Fonts Configuration
  fonts.packages = with pkgs; [
    inter
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    liberation_ttf
    fira-code-symbols
    mplus-outline-fonts.githubRelease
    dina-font
    proggyfonts
    roboto
    (nerdfonts.override {fonts = ["FiraCode" "DroidSansMono" "Hack" "JetBrainsMono" "RobotoMono"];})
  ];

  #VMware
  virtualisation.vmware.host.enable = true;
  security.polkit.enable = true;
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.policykit.exec" && subject.user == "estebandev") {
            return polkit.Result.YES;
        }
    });
  '';

  # Steam
  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
    dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
    localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
    gamescopeSession.enable = true;
  };

  # Docker
  virtualisation.docker.enable = true;

  services.gvfs.enable = true;

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-run"
    ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
