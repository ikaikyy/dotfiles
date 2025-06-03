import { bind } from "astal";
import { Gtk } from "astal/gtk4";
import AstalBattery from "gi://AstalBattery";
import Icon from "../Icon";

const battery = AstalBattery.get_default();

export default function Battery() {
  if (!battery.isPresent) {
    return null;
  }

  return bind(battery, "batteryIconName").as((batteryIconName) => (
    <box cssClasses={["battery"]} spacing={8} valign={Gtk.Align.CENTER}>
      <Icon iconName={batteryIconName} />
    </box>
  ));
}
