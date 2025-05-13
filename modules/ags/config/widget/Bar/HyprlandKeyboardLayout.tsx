import { Variable } from "astal";
import { Gtk } from "astal/gtk4";
import { exec } from "astal/process";

import Hyprland from "gi://AstalHyprland";
import Icon from "../Icon";

function getFormattedKeyboardLayout(layout: string) {
  const layoutMap: Record<string, string> = {
    "English (US)": "US",
    "Portuguese (Brazil)": "BR",
  };

  return layoutMap[layout] || layout;
}

const hyprland = Hyprland.get_default();

const keyboardLayout = Variable("");

const currentKeyboardLayout = JSON.parse(
  exec("hyprctl devices -j"),
).keyboards.find((keyboard: any) => keyboard.main).active_keymap;

keyboardLayout.set(currentKeyboardLayout);

hyprland.connect("keyboard-layout", (_, __, layout) => {
  keyboardLayout.set(layout);
});

export default function HyprlandKeyboardLayout() {
  return (
    <box
      cssClasses={["hyprland-keyboard-layout"]}
      spacing={8}
      valign={Gtk.Align.CENTER}
    >
      <Icon icon="󰌌" size="large" />
      <label
        valign={Gtk.Align.CENTER}
        label={keyboardLayout().as((layout) =>
          getFormattedKeyboardLayout(layout),
        )}
      />
    </box>
  );
}
