import { createBinding, For } from "ags";
import { Gtk } from "ags/gtk4";
import Tray from "gi://AstalTray";

export default function SystemTray() {
  const tray = Tray.get_default();

  return (
    <box class="system-tray" valign={Gtk.Align.CENTER}>
      {
        <For each={createBinding(tray, "items")}>
          {(item: Tray.TrayItem) => {
            return (
              <menubutton
                class="system-tray-item"
                $={(self) => {
                  self.insert_action_group("dbusmenu", item.actionGroup);
                  createBinding(self, "active").subscribe(() => {
                    if (self.active) self.add_css_class("active");
                    else self.remove_css_class("active");
                  });
                }}
                tooltipText={createBinding(item, "tooltipMarkup")}
              >
                <image
                  iconName={createBinding(item, "iconName")}
                  valign={Gtk.Align.CENTER}
                />
                <Gtk.PopoverMenu
                  $={(self) => {
                    self.set_menu_model(item.menuModel);
                    self.add_css_class("system-tray-item-popover");
                  }}
                />
              </menubutton>
            );
          }}
        </For>
      }
    </box>
  );
}
