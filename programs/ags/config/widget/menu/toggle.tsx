import Icon from "../icon";
import menu from "../../lib/menu";
import { Gtk } from "ags/gtk4";

export default function MenuToggle() {
  return (
    <button
      halign={Gtk.Align.CENTER}
      valign={Gtk.Align.CENTER}
      class={menu.isVisible.as(
        (isVisible) => `menu-toggle ${isVisible ? "active" : ""}`,
      )}
      onClicked={() => menu.toggleVisibility()}
    >
      <Icon iconName="nix-snowflake" background="none" size={16} />
    </button>
  );
}
