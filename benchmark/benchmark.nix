# benchmark.nix
{ pkgs ? import <nixpkgs> { config.allowUnfree = true; } }:

pkgs.mkShell {
  name = "benchmark-env";

  packages = with pkgs; [
    # CPU benchmarks
    sysbench
    stress-ng

    # GPU benchmarks
    glmark2
    vulkan-tools

    # Disk benchmarks
    fio
    hdparm

    # General benchmark suite
    phoronix-test-suite
  ];

  shellHook = ''
    echo "Benchmarking environment"
    echo "Available tools:"
    echo " - sysbench (CPU)"
    echo " - stress-ng (CPU stress test)"
    echo " - glmark2 (OpenGL GPU test)"
    echo " - vulkaninfo / vkcube (Vulkan GPU test)"
    echo " - fio (Disk read/write test)"
    echo " - hdparm (Disk speed test)"
    echo " - phoronix-test-suite (General test suite)"
    echo ""
    echo "'phoronix-test-suite interactive' for a full system test"
  '';
}
