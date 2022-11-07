{ pkgs, ... }:

{
  # https://nixos.wiki/wiki/Btrfs
  fileSystems = {
    "/nix" = {
      neededForBoot = true;
      options = [ "compress=zstd" "noatime" ];
    };
    "/persistent" = {
      neededForBoot = true;
      options = [ "compress=zstd" ];
    };
  };
  # https://nixos.wiki/wiki/Xorg
  hardware.video.hidpi.enable = true;

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

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.pulseaudio.support32Bit = true;
  nixpkgs.config.pulseaudio = true;
}
