{...}: {
  programs.nixvim.plugins = {
    copilot-chat = {
      enable = true;

      settings = {
        model = "gpt-5-mini";

        window = {
          layout = "float";
          width = 0.8;
          height = 0.6;
          border = "solid";
          title = "  Github Copilot";
        };

        auto_fold = true;

        prompts = {
          Explain = {
            mapping = "<leader>ae";
            description = "AI Explain";
          };
          Review = {
            mapping = "<leader>ar";
            description = "AI Review";
          };
          Tests = {
            mapping = "<leader>at";
            description = "AI Generate tests";
          };
          Fix = {
            mapping = "<leader>af";
            description = "AI Fix";
          };
          Optimize = {
            mapping = "<leader>ao";
            description = "AI Optimize";
          };
          Docs = {
            mapping = "<leader>ad";
            description = "AI Generate documentation";
          };
        };
      };
    };
  };

  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<leader>ac";
      action = "<cmd>CopilotChatToggle<cr>";
    }
  ];
}
