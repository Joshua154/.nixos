{
  boot = {
    plymouth = {
      enable = true;
      theme = "bgrt";
    };
    kernelParams = ["quiet" "splash"];
  };
}
