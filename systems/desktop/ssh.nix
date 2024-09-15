{
  services.openssh = {
    enable = true;
    settings = {
      PermitRootLogin = "no";
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
    };
  };
  programs.ssh.hostKeyAlgorithms = [ "sk-ssh-ed25519@openssh.com" "ssh-ed25519" "ecdsa-sha2-nistp256" ];
}
