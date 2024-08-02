{
  config,
  lib,
  pkgs,
  modulesPath,
  ...
}: {
  #usar mi gpu para poder ejcutar algunos video o  juegos
  services.xserver.videoDrivers = ["amdgpu" "modesetting"];
  systemd.tmpfiles.rules = [
    "L+    /opt/rocm/hip   -    -    -     -    ${pkgs.rocmPackages.clr}"
  ];
  #para los videos y herramientas de gpu
  environment.systemPackages = with pkgs; [
    xorg.xf86videoamdgpu
    vulkan-loader
    vulkan-tools
    clinfo
    # radeontop
    ocl-icd
  ];

  #para abrir lso juegos mas pesado o realista graficos, tambien para aplicacion que usa GPU
  #esto para exportar variables
  environment.variables = {
    LD_LIBRARY_PATH = "${pkgs.vulkan-loader}/lib";
  };

  hardware.graphics = {
    # driSupport = true;
    # driSupport32Bit = true;
    extraPackages = with pkgs; [
      mesa.drivers
      amdvlk
      driversi686Linux.amdvlk
      rocmPackages.clr.icd
    ];
    extraPackages32 = with pkgs; [driversi686Linux.amdvlk];
  };
}
