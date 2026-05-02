{
  config,
  pkgs,
  ...
}:
{
  programs._1password.enable = true;
  programs._1password-gui = {
    enable = true;
    polkitPolicyOwners = [ "ikaikyy" ];
  };

  environment.etc = {
    "1password/custom_allowed_browsers" = {
      text = ''
        zen-twilight
        zen-twilight-bin
      '';
      mode = "0755";
    };
  };
}
