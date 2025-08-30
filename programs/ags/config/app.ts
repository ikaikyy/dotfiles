import app from "ags/gtk4/app";
import style from "./styles/index.scss";

import Bar from "./widget/bar";

import appLauncher from "./lib/app-launcher";
import AppLauncher from "./widget/app-launcher";

app.start({
  css: style,
  main() {
    app.get_monitors().map(Bar, AppLauncher());
  },
  requestHandler: (argv, res) => {
    appLauncher.handleAgsRequest(argv, res);
  },
});
