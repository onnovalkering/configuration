{ pkgs, ... }:
{
  boot = {
    initrd = {
      availableKernelModules = [
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
    kernelParams = [ ];

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };
  };

  hardware = {
    cpu.intel.updateMicrocode = true;
    enableRedistributableFirmware = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
    };
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
              size = "200G";
              content = {
                type = "filesystem";
                format = "ext4";
                mountpoint = "/";
              };
            };
            swap = {
              size = "8G";
              content = {
                type = "swap";
                randomEncryption = true;
              };
            };
          };
        };
      };
    };
  };
}
