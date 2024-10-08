{ ... }: {
  programs.ssh = {
    enable = true;
    forwardAgent = true;
    serverAliveInterval = 120;

    includes = [
      "~/.ssh/org.conf"
      "~/.ssh/thaumy.conf"
    ];

    extraConfig = ''
      # Enabling SSH connections over HTTPS
      Host github.com
          Hostname ssh.github.com
          Port 443
          User git
    '';
  };
}
