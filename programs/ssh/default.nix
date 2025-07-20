{
  config,
  pkgs,
  ...
}: {
  programs.ssh.extraConfig = ''
    Host bitbucket-lab2dev
      HostName bitbucket.org
    	User git
    	IdentityFile ~/.ssh/id_ed25519_lab2dev

    Host bitbucket-id360nm
    	HostName bitbucket.org
    	User git
    	IdentityFile ~/.ssh/id_ed25519_id360nm
  '';
}
