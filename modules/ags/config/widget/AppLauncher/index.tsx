import { App, Astal, Gdk, Gtk, astalify } from "astal/gtk4";
import { Variable } from "astal";

import Icon from "../Icon";
import IconButton from "../IconButton";
import AppLauncherController from "./controller";

export const APP_LAUNCHER_WINDOW_NAME = "AppLauncher";

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
            onActivate={appLaunchController.launchSelectedApp}
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
            spacing={8}
          >
            {appLaunchController.appList().as((appList) =>
              appList.map((app, index) => {
                if (appLaunchController.selectedIndex.get() === index) {
                  const ITEM_HEIGHT = 44;
                  const ITEM_SPACING = 8;

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
                      spacing={8}
                    >
                      <Icon iconName={app.iconName} size={24} />
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

export function AppLauncherIconButton() {
  return appLaunchController.isVisible().as((visible) => {
    const cssClasses = ["app-launcher-icon-button"];

    if (visible) {
      cssClasses.push("active");
    }

    return (
      <IconButton
        iconName={"nix-snowflake"}
        size={24}
        onButtonPressed={() => appLaunchController.toggle()}
        cssClasses={cssClasses}
      />
    );
  });
}
