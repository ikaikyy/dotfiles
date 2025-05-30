import { Gdk, Gtk } from "astal/gtk4";

import Icon, { IconProps } from "../Icon";

type IconButtonProps = IconProps & {
  onButtonPressed?: () => void;
};

export default function IconButton({
  iconName,
  size,
  onButtonPressed,
  ...props
}: IconButtonProps) {
  return (
    <box
      {...props}
      cursor={Gdk.Cursor.new_from_name("pointer", null)}
      onButtonPressed={onButtonPressed}
      halign={Gtk.Align.CENTER}
      valign={Gtk.Align.CENTER}
    >
      <Icon iconName={iconName} size={size} />
    </box>
  );
}
