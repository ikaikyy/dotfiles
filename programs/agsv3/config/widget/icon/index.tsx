import { Image } from "astal/gtk4/widget";
import { getIconPaintable } from "../../lib/icon-theme";
import { Gtk } from "ags/gtk4";

export type IconProps = {
  iconName: string;
  size?: number;
};

export default function Icon({ iconName, size = 24 }: IconProps) {
  const iconPaintable = getIconPaintable(iconName, size);

  return (
    <box class="icon" valign={Gtk.Align.CENTER} halign={Gtk.Align.CENTER}>
      <Image
        paintable={iconPaintable}
        heightRequest={size}
        widthRequest={size}
      />
    </box>
  );
}
