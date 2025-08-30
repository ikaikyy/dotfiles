import app from "ags/gtk4/app";
import { Accessor, createComputed, createState, Setter } from "ags";

import Apps from "gi://AstalApps";
import { Gdk } from "ags/gtk4";

export const APP_LAUNCHER_WINDOW_NAME = "AppLauncher";

class AppLauncher {
  public readonly windowName = APP_LAUNCHER_WINDOW_NAME;

  private readonly apps = new Apps.Apps();
  public readonly searchQuery: Accessor<string>;
  public readonly selectedIndex: Accessor<number>;
  public readonly isVisible: Accessor<boolean>;
  private readonly setSearchQuery: Setter<string>;
  private readonly setSelectedIndex: Setter<number>;
  private readonly setIsVisible: Setter<boolean>;

  public readonly appsList: Accessor<Apps.Application[]>;

  constructor() {
    const [searchQuery, setSearchQuery] = createState("");
    const [selectedIndex, setSelectedIndex] = createState(0);
    const [isVisible, setIsVisible] = createState(false);
    this.searchQuery = searchQuery;
    this.selectedIndex = selectedIndex;
    this.isVisible = isVisible;
    this.setSearchQuery = setSearchQuery;
    this.setSelectedIndex = setSelectedIndex;
    this.setIsVisible = setIsVisible;

    this.appsList = createComputed((get) => {
      const query = get(this.searchQuery);

      return this.apps
        .exact_query(query)
        .filter((app) => app.name.toLowerCase().includes(query.toLowerCase()))
        .sort((a, b) => {
          if (a.name.toLowerCase() < b.name.toLowerCase()) return -1;
          if (a.name.toLowerCase() > b.name.toLowerCase()) return 1;
          return 0;
        });
    });
  }

  selectNextApp() {
    const currentIndex = this.selectedIndex.get();
    const appListLength = this.appsList.get().length;
    if (currentIndex < appListLength - 1) {
      this.setSelectedIndex(currentIndex + 1);
    } else {
      this.setSelectedIndex(0); // Wrap around to the first app
    }
  }

  selectPreviousApp() {
    const currentIndex = this.selectedIndex.get();
    const appListLength = this.appsList.get().length;
    if (currentIndex > 0) {
      this.setSelectedIndex(currentIndex - 1);
    } else {
      this.setSelectedIndex(appListLength - 1); // Wrap around to the last app
    }
  }

  launchSelectedApp() {
    const selectedApp = this.appsList.get()[this.selectedIndex.get()];

    if (selectedApp) {
      selectedApp.launch();
      this.hideWindow();
    }
  }

  launchAppAtIndex(index: number) {
    const appsList = this.appsList.get();

    if (index >= 0 && index < appsList.length) {
      appsList[index].launch();
      this.hideWindow();
    }
  }

  showWindow() {
    const window = app.get_window(this.windowName);

    if (window) {
      this.apps.reload();
      window.show();
      this.setIsVisible(true);
    }
  }

  hideWindow() {
    const window = app.get_window(this.windowName);

    if (window) {
      this.setSearchQuery("");
      this.setSelectedIndex(0);
      window.hide();
      this.setIsVisible(false);
    }
  }

  toggleWindowVisibility() {
    if (this.isVisible.get()) {
      this.hideWindow();
    } else {
      this.showWindow();
    }
  }

  handleSearchQueryChange(newQuery: string) {
    if (newQuery !== this.searchQuery.get()) {
      this.setSearchQuery(newQuery);
    }
    this.setSelectedIndex(-1);
  }

  handleKeyPress(keyval: number) {
    const keybindings: Record<number, () => void> = {
      [Gdk.KEY_Escape]: () => this.hideWindow(),
      [Gdk.KEY_Up]: () => this.selectPreviousApp(),
      [Gdk.KEY_Down]: () => this.selectNextApp(),
      [Gdk.KEY_ISO_Left_Tab]: () => this.selectPreviousApp(),
      [Gdk.KEY_Tab]: () => this.selectNextApp(),
      [Gdk.KEY_Return]: () => this.launchSelectedApp(),
    };

    if (keybindings[keyval]) {
      keybindings[keyval]();
      return true; // Indicate that the key press was handled
    }

    return false; // Indicate that the key press was not handled
  }

  handleAgsRequest(argv: string[], res: (response: string) => void) {
    const request = argv[0];

    switch (request) {
      case "show-app-launcher":
        this.showWindow();
        res("ok");
        break;

      case "hide-app-launcher":
        this.hideWindow();
        res("ok");
        break;

      case "toggle-app-launcher":
        this.toggleWindowVisibility();
        res("ok");
        break;

      default:
        res("command not found");
        break;
    }
  }
}

export default new AppLauncher();
