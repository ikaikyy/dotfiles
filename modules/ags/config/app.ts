import { App } from "astal/gtk4";
import style from "./style.scss";
import Bar from "./widget/Bar";
import AppLauncher, { appLaunchController } from "./widget/AppLauncher";

App.start({
  css: style,
  main() {
    Bar();
    AppLauncher();
  },
  requestHandler: (request, res) => {
    appLaunchController.requestHandler(request, res);
  },
});
