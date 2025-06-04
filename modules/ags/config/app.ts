import { App } from "astal/gtk4";
import style from "./style.scss";
import Bar from "./widget/Bar";
import AppLauncher, { appLaunchController } from "./widget/AppLauncher";
import PowerMenu from "./widget/PowerMenu";

App.start({
  css: style,
  main() {
    AppLauncher();
    PowerMenu();
    Bar();
  },
  requestHandler: (request, res) => {
    appLaunchController.requestHandler(request, res);
  },
});
