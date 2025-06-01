import { bind } from "astal";
import { Gtk, astalify } from "astal/gtk4";
import Tray from "gi://AstalTray";

const PopoverMenu = astalify(Gtk.PopoverMenu);

export default function SystemTray() {
  const tray = Tray.get_default();

  return (
    <box cssClasses={["system-tray"]} valign={Gtk.Align.CENTER}>
      {bind(tray, "items").as((items) =>
        items.map((item) => (
          <menubutton
            cssClasses={["system-tray-item"]}
            setup={(self) => {
              self.insert_action_group("dbusmenu", item.actionGroup);

              bind(self, "active").subscribe((active) => {
                if (active) {
                  self.add_css_class("active");
                } else {
                  self.remove_css_class("active");
                }
              });
            }}
            tooltipText={bind(item, "tooltipMarkup")}
          >
            <image gicon={bind(item, "gicon")} valign={Gtk.Align.CENTER} />
            <PopoverMenu
              setup={(self) => {
                self.set_menu_model(item.menuModel);
                self.add_css_class("system-tray-item-popover");
              }}
            />
          </menubutton>
        )),
      )}
    </box>
  );
}
