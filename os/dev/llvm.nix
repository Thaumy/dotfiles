{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      lldb
      clang
      libllvm
      clang-tools
    ];

    etc."sdk-homes/llvm".source = pkgs.libllvm;
  };
}
