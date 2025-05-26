import { Gdk, Gtk } from "astal/gtk4";

import Icon, { IconProps } from "../Icon";

type IconButtonProps = IconProps & {
  cssClasses?: string[];
  onButtonPressed?: () => void;
};

export default function IconButton({
  iconName,
  size,
  cssClasses,
  onButtonPressed,
}: IconButtonProps) {
  return (
    <box
      cursor={Gdk.Cursor.new_from_name("pointer", null)}
      cssClasses={cssClasses.concat(["icon-button"])}
      onButtonPressed={onButtonPressed}
      halign={Gtk.Align.CENTER}
      valign={Gtk.Align.CENTER}
    >
      <Icon iconName={iconName} size={size} />
    </box>
  );
}
