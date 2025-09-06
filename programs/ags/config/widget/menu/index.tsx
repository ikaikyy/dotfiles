import { Gtk } from "ags/gtk4";
import NotificationsManager from "../notifications/manager";
import { createBinding } from "ags";
import Icon from "../icon";

export default function Menu() {
  return (
    <menubutton
      class="menu-toggle"
      halign={Gtk.Align.CENTER}
      valign={Gtk.Align.CENTER}
      $={(self) => {
        createBinding(self, "active").subscribe(() => {
          if (self.active) self.add_css_class("active");
          else self.remove_css_class("active");
        });
      }}
    >
      <Icon iconName="nix-snowflake" background="none" size={16} />
      <popover class="menu-popover">
        <NotificationsManager />
      </popover>
    </menubutton>
  );
}
