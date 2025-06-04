import { App } from "astal/gtk4";
import { Variable } from "astal";

import Apps from "gi://AstalApps";

export const APP_LAUNCHER_WINDOW_NAME = "AppLauncher";

export default class AppLauncherController {
  readonly searchQuery: Variable<string> = new Variable("");
  readonly selectedIndex: Variable<number> = new Variable(0);
  readonly isVisible: Variable<boolean> = new Variable(false);

  readonly apps: Apps.Apps = new Apps.Apps();
  readonly appList: Variable<Apps.Application[]> = Variable.derive(
    [this.selectedIndex, this.searchQuery],
    (_, searchQuery) => {
      const appList = this.apps.fuzzy_query(searchQuery).sort((a, b) => {
        if (a.name.toLowerCase() < b.name.toLowerCase()) return -1;
        if (a.name.toLowerCase() > b.name.toLowerCase()) return 1;
        return 0;
      });

      return appList;
    },
  );

  navigate(direction: "up" | "down") {
    const currentIndex = this.selectedIndex.get();
    const appListLength = this.appList.get().length;

    switch (direction) {
      case "up":
        if (currentIndex > 0) {
          this.selectedIndex.set(currentIndex - 1);
        } else {
          this.selectedIndex.set(appListLength - 1); // Wrap around to the last app
        }
        break;
      case "down":
        if (currentIndex < appListLength - 1) {
          this.selectedIndex.set(currentIndex + 1);
        } else {
          this.selectedIndex.set(0); // Wrap around to the first app
        }
        break;
    }
  }

  launchSelectedApp() {
    const selectedApp = this.appList.get()[this.selectedIndex.get()];

    if (selectedApp) {
      selectedApp.launch();
      this.hide();
    }
  }

  launchAppAtIndex(index: number) {
    const appList = this.appList.get();

    if (index >= 0 && index < appList.length) {
      appList[index].launch();
      this.hide();
    }
  }

  show() {
    const window = App.get_window(APP_LAUNCHER_WINDOW_NAME);

    if (window) {
      this.apps.reload();
      window.show();
      this.isVisible.set(true);
    }
  }

  hide() {
    const window = App.get_window(APP_LAUNCHER_WINDOW_NAME);

    if (window) {
      this.searchQuery.set("");
      this.selectedIndex.set(0);
      window.hide();
      this.isVisible.set(false);
    }
  }

  toggle() {
    if (this.isVisible.get()) {
      this.hide();
    } else {
      this.show();
    }
  }

  requestHandler(request: string, res: (response: string) => void) {
    switch (request) {
      case "show-app-launcher":
        this.show();
        res("ok");
        break;

      case "hide-app-launcher":
        this.hide();
        res("ok");
        break;

      case "toggle-app-launcher":
        this.toggle();
        res("ok");
        break;

      default:
        res("command not found");
        break;
    }
  }
}
