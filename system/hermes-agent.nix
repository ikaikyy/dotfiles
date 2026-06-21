{ config, ... }: {
  services.hermes-agent = {
    enable = true;
    settings.model.default = "opencode-go/deepseek-v4-pro";
    addToSystemPackages = true;
  };
}
