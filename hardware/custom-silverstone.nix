{ pkgs, ... }:
{
  boot = {
    initrd = {
      availableKernelModules = [
        "ahci"
        "nvme"
        "sd_mod"
        "sdhci_pci"
        "usb_storage"
        "usbhid"
        "xhci_pci"
      ];
    };

    kernelModules = [ "kvm-intel" ];
    kernelPackages = pkgs.linuxPackages_6_18;
    kernelParams = [
      "vm.swappiness=180"
      "vm.page-cluster=0"
    ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;
  };

  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 100;
  };

  networking = {
    interfaces.eth0.useDHCP = true;
  };

  disko.devices = {
    disk = {
      main = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            ESP = {
              type = "EF00";
              size = "512M";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot";
                mountOptions = [ "umask=0077" ];
              };
            };
            root = {
              size = "100%";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
            swap = {
              size = "4G";
              content = {
                type = "swap";
                discardPolicy = "both";
                randomEncryption = true;
                priority = 5;
              };
            };
          };
        };
      };
    };
  };
}
