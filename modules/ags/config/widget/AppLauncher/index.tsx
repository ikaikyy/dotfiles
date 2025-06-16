import { App, Astal, Gdk, Gtk, astalify } from "astal/gtk4";
import { Variable } from "astal";

import Icon from "../Icon";
import AppLauncherController, { APP_LAUNCHER_WINDOW_NAME } from "./controller";

const ScrolledWindow = astalify(Gtk.ScrolledWindow);

export const appLaunchController = new AppLauncherController();
function onKeyPressed(_, key: number) {
  switch (key) {
    case Gdk.KEY_Escape:
      appLaunchController.hide();
      break;

    case Gdk.KEY_Up:
      appLaunchController.navigate("up");
      return true;

    case Gdk.KEY_Down:
      appLaunchController.navigate("down");
      return true;

    case Gdk.KEY_ISO_Left_Tab:
      appLaunchController.navigate("up");
      return true;

    case Gdk.KEY_Tab:
      appLaunchController.navigate("down");
      return true;

    default:
      break;
  }
}

export default function AppLauncher() {
  const scrolledWindow = Variable<Gtk.ScrolledWindow | null>(null);

  return (
    <window
      application={App}
      name={APP_LAUNCHER_WINDOW_NAME}
      namespace={APP_LAUNCHER_WINDOW_NAME}
      layer={Astal.Layer.OVERLAY}
      cssClasses={[APP_LAUNCHER_WINDOW_NAME]}
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
        spacing={12}
      >
        <box cssClasses={["header"]} spacing={12} hexpand={true}>
          <Icon iconName="nix-snowflake" size={32} />
          <entry
            cssClasses={["search-input"]}
            placeholderText="Search for an app..."
            onActivate={() => appLaunchController.launchSelectedApp()}
            text={appLaunchController.searchQuery()}
            onNotifyText={(self) => {
              if (self.text !== appLaunchController.searchQuery.get()) {
                appLaunchController.searchQuery.set(self.text);
              }

              self.set_position(-1);
            }}
            hexpand={true}
          />
        </box>
        <ScrolledWindow
          vexpand={true}
          setup={(self) => scrolledWindow.set(self)}
        >
          <box
            cssClasses={["app-list"]}
            orientation={Gtk.Orientation.VERTICAL}
            spacing={12}
          >
            {appLaunchController.appList().as((appList) =>
              appList.map((app, index) => {
                if (appLaunchController.selectedIndex.get() === index) {
                  const ITEM_HEIGHT = 48;
                  const ITEM_SPACING = 12;

                  scrolledWindow
                    .get()
                    ?.get_vadjustment()
                    .set_value((ITEM_HEIGHT + ITEM_SPACING) * index);
                }

                return (
                  <button
                    canFocus={false}
                    cursor={Gdk.Cursor.new_from_name("pointer", null)}
                    onClicked={() =>
                      appLaunchController.launchAppAtIndex(index)
                    }
                  >
                    <box
                      cssClasses={[
                        "app",
                        appLaunchController.selectedIndex.get() === index
                          ? "selected"
                          : "",
                      ]}
                      spacing={12}
                    >
                      <Icon iconName={app.iconName} size={32} />
                      <label label={app.name} cssClasses={["app-name"]} />
                    </box>
                  </button>
                );
              }),
            )}
          </box>
        </ScrolledWindow>
      </box>
    </window>
  );
}
