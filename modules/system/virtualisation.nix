{username, ...}: {
  users.users.${username}.extraGroups = ["vboxusers"];

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
        swtpm.enable = true;
      };
    };

    spiceUSBRedirection.enable = true;

    virtualbox.host.enable = true;
  };
}
