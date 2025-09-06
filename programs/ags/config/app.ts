import app from "ags/gtk4/app";
import style from "./styles/index.scss";

import Bar from "./widget/bar";

import appLauncher from "./lib/app-launcher";
import AppLauncher from "./widget/app-launcher";
import Menu from "./widget/menu";

app.start({
  css: style,
  main() {
    Bar();
    AppLauncher();
    Menu()
  },
  requestHandler: (argv, res) => {
    appLauncher.handleAgsRequest(argv, res);
  },
});
