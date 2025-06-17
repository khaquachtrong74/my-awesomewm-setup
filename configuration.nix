# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{ config, lib, pkgs, ... }:
{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./nbfc.nix  # Fan control
    (import ./modules/sddm.nix {
        inherit pkgs lib;
        themeName = "where_is_my_sddm_theme";
        themePackage = pkgs.where-is-my-sddm-theme.override {
            themeConfig.General = {
                background = toString ./images/sddm_background.png;
                backgroundMode = "fill";
            };
        };

        isWayland = true;
        dependencies = with pkgs; [ 
            kdePackages.qt5compat
            kdePackages.qtdeclarative
        ];
    })
 ];
  # Use the systemd-boot EFI boot loader.
#  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub.enable = true;
  boot.loader.grub.devices = [ "nodev" ];
  boot.loader.grub.efiSupport=true;
  boot.loader.grub.useOSProber = true;

   networking.hostName = "nixos"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
   networking.networkmanager.enable = true;  # Easiest to use and most distros use this by default.
   networking.firewall.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Ho_Chi_Minh";
  system.copySystemConfiguration = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  nixpkgs.config.allowUnfree=true;
location.provider = "geoclue2";
location = {
	latitude = "10.7769";
	longitude = "106.7009";
};

services={
        xserver = {
            enable = true;
            videoDrivers = [ "nvidia" ];
            windowManager.awesome = {
                enable = true;
                luaModules = with pkgs.lua51Packages; [
                    luarocks # is the package manager for Lua modules
                    luadbi-mysql # Database abstraction layer
                    luarocks-nix
                    lua
                ];
            };
        };
        displayManager = {
            defaultSession = "none+awesome";
        };
        # REMEMBER______________________
        upower ={ # FOr limit charge
            enable=true;
        };
        pipewire = {
            enable = true;
            pulse.enable = true;
        };
        redshift = {
            enable = false;
            brightness = {
              day = "1";
              night = "1";
            };
            temperature = {
                day = 5500;
                night = 3700;
            };
        };
};
fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [ 
        nerd-fonts.noto
        nerd-fonts.symbols-only
        noto-fonts-cjk-sans
    ];
};
hardware = {
    graphics = {
        enable = true;
        enable32Bit = true;
        extraPackages = with pkgs; [ 
            vaapiIntel
            intel-ocl
            intel-media-driver
            libvdpau-va-gl
            nvidia-vaapi-driver
        ];
    };
    bluetooth = {
        enable = true; # enables support for Bluetooth
        powerOnBoot = true; # powers up the default Bluetooth controller on boot
        settings = {
          General = { 
            Enable = "Source,Sink,Media,Socket";
          };
        };
    };
    nvidia = { 
        modesetting.enable = true;
        open = false;
        nvidiaSettings = true;
        powerManagement = {
            enable = false;
            finegrained = false;
        };
        prime = {
            sync.enable = true;
            intelBusId = "PCI:0:2:0";
            nvidiaBusId = "PCI:1:0:0";
        };
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        forceFullCompositionPipeline = true;
        };
        cpu.intel.updateMicrocode = true;
};
boot.kernelParams = [
    "i915.enable_psr=0"       
    "i915.enable_guc=2"       
    "i915.enable_fbc=1"       
];

nixpkgs.config.nvidia.acceptLicense = true;



services.blueman.enable=true;
security.polkit.enable=true;
  # Configure keymap in X11
  services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  # services.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.khat = {
     isNormalUser = true;
     extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
     packages = with pkgs; [
       tree
       unzip
       upower
       prometheus-nvidia-gpu-exporter
       brightnessctl
       bluez
       heroic
       bluez-tools
       go
       conda
       picom
       fastfetch
       python314
       python313Packages.pip
       gcc
       obs-studio
       flameshot
       kdePackages.kdenlive
       vesktop
       nodejs_24
       cava  #rice
       pipes #rice
#       libreoffice-qt6-fresh
       xclip
       anydesk
       obsidian
       vscode
     ];
   };

  programs.firefox.enable = true;


  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).

 environment.systemPackages = with pkgs; [
   vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
   wget
   git
   alacritty
   neovim
   btop
   pamixer
   nvtopPackages.nvidia
   toybox
   syncthing
   pcmanfm
   pulseaudioFull
   awesome
   live-server
   lm_sensors
   sddm-astronaut
];


i18n.inputMethod = {
    enabled = "fcitx5";
    fcitx5.addons = with pkgs; [
        fcitx5-unikey
    ];
};

environment.sessionVariables = {
  GTK_IM_MODULE = "fcitx";
  QT_IM_MODULE = "fcitx";
  SDL_IM_MODULE = "fcitx";
  XMODIFIERS = "@im=fcitx";
};

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
  system.stateVersion = "25.05"; # Did you read the comment?
  # Virtual machine
}

