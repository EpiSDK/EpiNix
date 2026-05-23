# Main configuration file (system-wide). Applies to all users.

{ config, pkgs, lib, inputs, ... }:

{
    imports = [
        ./hardware-configuration.nix
    ];

    nixpkgs.config.allowUnfree = true;

    # Boot section

    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.systemd-boot.configurationLimit = 2;
    boot.kernelPackages = pkgs.linuxPackages;

    # Network Section

    networking.hostName = "nixos";
    networking.networkmanager.enable = true;

    # Bluetooth section

    hardware.bluetooth.enable = true;
    services.blueman.enable = true;

    services.fprintd.enable = true;
    
    # Security Section

    security.pam.services = {
        login.fprintAuth = lib.mkForce true;
        sudo.fprintAuth = false;
        polkit-1.fprintAuth = true;
        gdm-fingerprint.fprintAuth = true;
    };

    # Hardware Section

    hardware.graphics = {
        enable = true;
        extraPackages = with pkgs; [
            intel-media-driver
            intel-vaapi-driver
            libva-vdpau-driver
            libvdpau-va-gl
        ];
    };

    services.thermald.enable = true;
    powerManagement.enable = true;

    # Time Section

    time.timeZone = "Europe/Paris";
    i18n.defaultLocale = "fr_FR.UTF-8";
    console.keyMap = "fr";

    # Gnome Section

    services.displayManager.gdm.enable = true;
    services.desktopManager.gnome.enable = true;
    services.displayManager.autoLogin.user = "User"; # Replace "User" with your username
    services.xserver.xkb = {
        layout = "fr";
        variant = "";
    };

    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
        enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
    };

    # Open SSH Section

    services.openssh = {
        enable = true;
        settings = {
            PasswordAuthentication = false;
            PermitRootLogin = "no";
        };
    };

    programs.fish.enable = true;

    users.users.user = {            # Rename "user" to your username
        isNormalUser = true;
        description = "User";       # Replace "User" with your display name
        extraGroups = [ "wheel" "networkmanager" "docker" ];
        shell = pkgs.fish;
    };
  
    programs.dconf.enable = true;

    services.accounts-daemon.enable = true;
    environment.etc."AccountsService/users/root".text = ''
        [User]
        SystemAccount=true
    '';


    # Packages: system-wide packages installed for all users on this machine.
    # You can add your own packages. See "https://search.nixos.org/packages?query=" for available packages.

    environment.systemPackages = with pkgs; [
        git                         # Git
        curl                        # Web requests
        vim                         # Terminal text editor
        htop                        # Top, but better
        python3                     # Python

        llvmPackages_20.clang       # Clang C/C++ compiler
        llvmPackages_20.llvm        # LLVM libraries
        gcovr                       # Coverage reports
        criterion                   # C unit testing framework
        valgrind                    # Memory debugging for C/C++
        gnumake42                   # GNU Make
    ];

    # Docker Setting Section

    virtualisation.docker.enable = true;

    hardware.enableRedistributableFirmware = true;

    nix.settings = {
        experimental-features = [ "nix-command" "flakes" ];
        auto-optimise-store = true;
    };

    nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
    };

    # Font Section

    fonts.packages = with pkgs; [
        nerd-fonts.jetbrains-mono
    ];

    programs.nix-ld = {
        enable = true;
        libraries = with pkgs; [
            stdenv.cc.cc.lib
            zlib
            openssl
        ];
    };

    system.stateVersion = "26.05";
}
