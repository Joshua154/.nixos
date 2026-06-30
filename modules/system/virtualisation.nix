{
  virtualisation = {
    docker = {
      enable = true;
      rootless = {
        enable = true;
        setSocketVariable = true;
      };
    };

    libvirtd = {
      enable = true;
      qemu = {
        # ovmf.enable = true;
        swtpm.enable = true;
      };
    };

    spiceUSBRedirection.enable = true;

    virtualbox.host.enable = true;
  };
}
