{
  host,
  lib,
  pkgs,
  ...
}: {
  environment.systemPackages = [pkgs.sbctl];
  boot.loader = {
    efi.canTouchEfiVariables = true;
    timeout = 5;
    limine = {
      enable = true;
      maxGenerations = lib.mkDefault 3;
      secureBoot.enable = host.secureBoot or false;
      extraConfig = "remember_last_entry: yes";
      extraEntries = ''
        /Windows
          protocol: efi_boot_entry
          entry: Windows Boot Manager
      '';

      package = pkgs.limine.overrideAttrs (old: {
        postPatch =
          (old.postPatch or "")
          + ''
            substituteInPlace common/menu.c --replace-fail \
              'find_entry_by_path(last_entry_path, menu_tree, 0, &found_entry, &found_index, true);' \
              "if (strchr(last_entry_path, '/') == NULL)
                            find_entry_by_path(last_entry_path, menu_tree, 0, &found_entry, &found_index, true);"
          '';
      });
    };
  };
}
