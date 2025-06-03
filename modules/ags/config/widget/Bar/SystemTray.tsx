import { bind } from "astal";
import { Gdk, Gtk, astalify } from "astal/gtk4";
import Tray from "gi://AstalTray";

const PopoverMenu = astalify(Gtk.PopoverMenu);

const IconTheme = Gtk.IconTheme.get_for_display(Gdk.Display.get_default());

export default function SystemTray() {
  const tray = Tray.get_default();

  return (
    <box cssClasses={["system-tray"]} valign={Gtk.Align.CENTER}>
      {bind(tray, "items").as((items) =>
        items.map((item) => {
          return (
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
              <image
                paintable={bind(item, "iconName").as((iconName) => {
                  let iconPaintable: Gtk.IconPaintable;

                  if (iconName) {
                    iconPaintable = IconTheme.lookup_icon(
                      iconName,
                      null,
                      16,
                      1,
                      null,
                      null,
                    );
                  } else if (item.gicon) {
                    iconPaintable = IconTheme.lookup_by_gicon(
                      item.gicon,
                      16,
                      1,
                      null,
                      null,
                    );
                  } else {
                    iconPaintable = IconTheme.lookup_icon(
                      "application-x-executable",
                      null,
                      16,
                      1,
                      null,
                      null,
                    );
                  }

                  return iconPaintable;
                })}
                valign={Gtk.Align.CENTER}
              />
              <PopoverMenu
                setup={(self) => {
                  self.set_menu_model(item.menuModel);
                  self.add_css_class("system-tray-item-popover");
                }}
              />
            </menubutton>
          );
        }),
      )}
    </box>
  );
}
