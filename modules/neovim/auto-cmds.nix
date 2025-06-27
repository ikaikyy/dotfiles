{ pkgs, config, ... }: {
  programs.nixvim.autoCmd = [
    {
      event = "CmdlineEnter";
      pattern = "*";
      command = "setlocal cmdheight=1";
    }
    {
      event = "CmdlineLeave";
      pattern = "*";
      command = "setlocal cmdheight=0";
    }
    {
      event = "BufWritePre";
      callback.__raw = ''
        function()
          vim.lsp.buf.format({ async = false })
        end
      '';
    }
  ];
}
