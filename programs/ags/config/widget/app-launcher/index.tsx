import app from "ags/gtk4/app";
import { createComputed, createState, For } from "ags";
import { Astal, Gdk, Gtk } from "ags/gtk4";

import appLauncher from "../../lib/app-launcher";
import Icon from "../icon";

export default function AppLauncher() {
  const [scrolledWindowRef, setScrolledWindowRef] =
    createState<Gtk.ScrolledWindow | null>(null);

  return (
    <window
      application={app}
      name={appLauncher.windowName}
      namespace={appLauncher.windowName}
      class={appLauncher.windowName}
      layer={Astal.Layer.OVERLAY}
      heightRequest={600}
      widthRequest={800}
      monitor={0}
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.EXCLUSIVE}
      visible={false}
    >
      <Gtk.EventControllerKey
        onKeyPressed={(_, keyval) => appLauncher.handleKeyPress(keyval)}
      />
      <box class="main" orientation={Gtk.Orientation.VERTICAL} spacing={8}>
        <box cssClasses={["header"]} spacing={8} hexpand={true}>
          <Icon iconName="nix-snowflake" size={44} background="rounded" />
          <entry
            class="search-input"
            placeholderText="Search for an app..."
            text={appLauncher.searchQuery}
            onActivate={() => appLauncher.launchSelectedApp()}
            onNotifyText={(self) =>
              appLauncher.handleSearchQueryChange(self.text)
            }
            hexpand={true}
          />
        </box>
        <scrolledwindow
          vexpand={true}
          $={(self: Gtk.ScrolledWindow) => setScrolledWindowRef(self)}
        >
          <box
            class="app-list"
            orientation={Gtk.Orientation.VERTICAL}
            spacing={8}
          >
            {
              <For each={appLauncher.appsList}>
                {(app, index) => {
                  appLauncher.selectedIndex.subscribe(() => {
                    if (appLauncher.selectedIndex.get() === index.get()) {
                      const ITEM_HEIGHT = 48;
                      const ITEM_SPACING = 8;
                      scrolledWindowRef
                        .get()
                        ?.get_vadjustment()
                        .set_value((ITEM_HEIGHT + ITEM_SPACING) * index.get());
                    }
                  });

                  return (
                    <button
                      canFocus={false}
                      cursor={Gdk.Cursor.new_from_name("pointer", null)}
                      onClicked={() =>
                        appLauncher.launchAppAtIndex(index.get())
                      }
                    >
                      <box
                        class={createComputed(
                          [index, appLauncher.selectedIndex],
                          (index, selectedIndex) =>
                            index === selectedIndex ? "app selected" : "app",
                        )}
                        spacing={12}
                      >
                        <Icon
                          iconName={app.iconName}
                          size={32}
                          background="rounded"
                        />
                        <label label={app.name} class="app-name" />
                      </box>
                    </button>
                  );
                }}
              </For>
            }
          </box>
        </scrolledwindow>
      </box>
    </window>
  );
}
