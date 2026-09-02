{
  services.neard.enable = true;

  services.neard.settings.General = {
    ConstantPoll = false;
    DefaultPowered = true;
    ResetOnError = true;
  };
}
