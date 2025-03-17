{ pkgs, ... }: {
  environment = {
    systemPackages = with pkgs; [
      lldb
      libllvm
      clang-tools
    ];

    etc."sdk-homes/llvm".source = pkgs.libllvm;
  };
}
