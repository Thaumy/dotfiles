{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    lldb
    clang
    libllvm
    clang-tools
  ];
}
