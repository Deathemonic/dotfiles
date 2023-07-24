{ config, lib, pkgs, modulesPath, ... }: {
  imports = [ ( modulesPath + "/installer/scan/not-detected.nix" ) ];

  boot = {
    initrd = {
      kernelModules = [ ];
      availableKernelModules = [ 
        "uhci_hcd" 
        "ehci_pci" 
        "ata_piix" 
        "firewire_ohci" 
        "usbhid" 
        "usb_storage" 
        "sd_mod" 
        "sr_mod" 
      ];
    };
    
    kernelModules = [ "wl" ];
    extraModulePackages = [ config.boot.kernelPackages.broadcom_sta ];
  };

  fileSystems."/" = { 
    device = "/dev/disk/by-uuid/d78269da-5932-4757-b59c-bab28dcfe2a7";
    fsType = "ext4";
  };

  swapDevices = [ 
    { device = "/dev/disk/by-uuid/af700b28-42dd-4e9f-aa03-6aa7686a22f6"; }
  ];

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
