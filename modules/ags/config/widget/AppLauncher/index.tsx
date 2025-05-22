import Apps from "gi://AstalApps";
import { App, Astal, Gdk, Gtk } from "astal/gtk4";
import { Variable } from "astal";

import Icon from "../Icon";

export const APP_LAUNCHER_WINDOW_NAME = "AppLauncher";

function onKeyPressed(self: Astal.Window, key: number) {
  switch (key) {
    case Gdk.KEY_Escape:
      self.hide();
      break;

    default:
      break;
  }
}

export default function AppLauncher() {
  const apps = new Apps.Apps();

  const selectedIndex = Variable(0);
  const searchText = Variable("");
  const appList = searchText((text) => {
    let appList = apps
      .exact_query(text)
      .filter((app) => app.name.toLowerCase().includes(text.toLowerCase()))
      .sort((a, b) => {
        if (a.name === b.name) {
          return 0;
        }
        let aMatch = a.name.toLowerCase().startsWith(text.toLowerCase());
        let bMatch = b.name.toLowerCase().startsWith(text.toLowerCase());
        if (aMatch && bMatch) {
          if (a.name > b.name) {
            return 1;
          } else {
            return -1;
          }
        } else if (aMatch) {
          return -1;
        } else {
          return 1;
        }
      });
    if (appList.length - 1 < selectedIndex.get()) {
      if (appList.length === 0) {
        selectedIndex.set(0);
      } else {
        selectedIndex.set(appList.length - 1);
      }
    }
    return appList;
  });

  return (
    <window
      application={App}
      name={APP_LAUNCHER_WINDOW_NAME}
      cssClasses={["AppLauncher"]}
      heightRequest={600}
      widthRequest={800}
      monitor={0}
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.EXCLUSIVE}
      visible={false}
      onKeyPressed={onKeyPressed}
    >
      <box
        cssClasses={["main"]}
        orientation={Gtk.Orientation.VERTICAL}
        spacing={8}
      >
        <box cssClasses={["header"]} spacing={8} hexpand={true}>
          <Icon iconName="nix-snowflake" size={32} />
          <entry
            cssClasses={["search-input"]}
            placeholderText="Search for an app..."
            onNotifyText={(self) => searchText.set(self.text)}
            onActivate={(self) => {
              const app = appList.get()[selectedIndex.get()];

              self.buffer.delete_text(0, -1);

              if (app) {
                app.launch();
                App.get_window(APP_LAUNCHER_WINDOW_NAME)?.hide();
              }
            }}
            hexpand={true}
          />
        </box>
        <Gtk.ScrolledWindow vexpand={true}>
          <box
            cssClasses={["app-list"]}
            orientation={Gtk.Orientation.VERTICAL}
            spacing={8}
          >
            {appList.as((appList) => {
              return appList.map((app, index) => (
                <box
                  cssClasses={[
                    "app",
                    selectedIndex.get() === index ? "selected" : "",
                  ]}
                  spacing={8}
                  onNotifySelected={() => {
                    selectedIndex.set(index);
                  }}
                >
                  <Icon iconName={app.iconName} size={24} />
                  <label label={app.name} cssClasses={["app-name"]} />
                </box>
              ));
            })}
          </box>
        </Gtk.ScrolledWindow>
      </box>
    </window>
  );
}
