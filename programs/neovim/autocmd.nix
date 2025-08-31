{
  config,
  lib,
  inputs,
  ...
}:
{
  programs.nixvim.autoGroups = {
    CmdlineHeight = {
      clear = true;
    };
  };

  programs.nixvim.autoCmd = [
    {
      desc = "Set cmdheight to 1 when entering command line mode";
      group = "CmdlineHeight";
      event = "CmdlineEnter";
      command = "setlocal cmdheight=1";
      pattern = "*";
    }
    {
      desc = "Set cmdheight to 0 when leaving command line mode";
      group = "CmdlineHeight";
      event = "CmdlineLeave";
      command = "setlocal cmdheight=0";
      pattern = "*";
    }
  ];
}
