import { App } from "astal/gtk4";
import style from "./style.scss";
import Bar from "./widget/Bar";
import AppLauncher, { APP_LAUNCHER_WINDOW_NAME } from "./widget/AppLauncher";

App.start({
  css: style,
  main() {
    Bar();
    AppLauncher();
  },
  requestHandler: (request, res) => {
    switch (request) {
      case "show-app-launcher":
        App.get_window(APP_LAUNCHER_WINDOW_NAME)?.show();
        res("ok");
        break;

      case "hide-app-launcher":
        App.get_window(APP_LAUNCHER_WINDOW_NAME)?.hide();
        res("ok");
        break;

      default:
        res("command not found");
        break;
    }
  },
});
