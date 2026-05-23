# Main configuration file. Use for all user

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

    # Bluetooth Section 

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
    services.displayManager.autoLogin.user = "User"; # Change "user" by your user
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

    users.users.user = {            # Change "user" by your user
        isNormalUser = true;
        description = "User";       # Change "User" by your own user 
        extraGroups = [ "wheel" "networkmanager" "docker" ];
        shell = pkgs.fish;
    };
  
    programs.dconf.enable = true;

    services.accounts-daemon.enable = true;
    environment.etc."AccountsService/users/root".text = ''
        [User]
        SystemAccount=true
    '';


    # Package Section : This section its for all packages for all user in your pc
    # You can add your own packages. See "https://search.nixos.org/packages?query=" for all packages in Nix 

    environment.systemPackages = with pkgs; [
        git                         # For github
        curl                        # For Web Request
        vim                         # Terminal text editor
        htop                        # Top but better
        python3                     # Python language

        llvmPackages_20.clang       # Clang for c compilateur
        llvmPackages_20.llvm        # Lib requirement
        gcovr                       # For coverage code
        criterion                   # Again for coverage code
        valgrind                    # See leak memory and error on C code
        gnumake42                   # Just make
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
