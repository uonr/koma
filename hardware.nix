{ pkgs, lib, ... }:

let
  sound = "pulseaudio";
  enablePipewire = sound == "pipewire";
  enablePulseAudio = sound == "pulseaudio";
in {
  # https://nixos.wiki/wiki/Btrfs
  fileSystems = {
    "/" = { options = [ "defaults" "size=4G" "mode=755" ]; };
    "/nix" = {
      neededForBoot = true;
      options = [ "compress=zstd" "noatime" ];
    };
    "/etc/ssh" = {
      depends = [ "/persistent" ];
      neededForBoot = true;
    };
    "/persistent" = {
      neededForBoot = true;
      options = [ "compress=zstd" ];
    };
  };
  # https://nixos.wiki/wiki/Xorg
  hardware.video.hidpi.enable = true;

  hardware.bluetooth.enable = true;

  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # https://nixos.wiki/wiki/AMD_GPU
  services.xserver.videoDrivers = [ "amdgpu" ];
  boot.initrd.kernelModules = [ "amdgpu" ];
  hardware.opengl.driSupport = true;
  # hardware.opengl.driSupport32Bit = true;
  hardware.opengl.extraPackages = with pkgs;
    [
      amdvlk
      # OpenCL
      # rocm-opencl-icd
      # rocm-opencl-runtime
    ];
  # hardware.opengl.extraPackages32 = with pkgs; [
  #   driversi686Linux.amdvlk
  # ];
  # environment.variables.AMD_VULKAN_ICD = "RADV";
  environment.variables.VK_ICD_FILENAMES =
    "/run/opengl-driver/share/vulkan/icd.d/radeon_icd.x86_64.json";

  sound.enable = false;
  hardware.pulseaudio = lib.mkIf enablePulseAudio {
    enable = true;
    support32Bit = true;
  };
  nixpkgs.config = lib.mkIf enablePulseAudio { pulseaudio = true; };

  # https://nixos.wiki/wiki/PipeWire
  security.rtkit = lib.mkIf enablePipewire { enable = true; };
  services.pipewire = lib.mkIf enablePipewire {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}
