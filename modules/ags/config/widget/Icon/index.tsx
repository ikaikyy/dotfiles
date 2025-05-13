import { Gtk } from "astal/gtk4";

const iconSizes = {
  small: 16,
  medium: 24,
  large: 32,
  extra_large: 48,
  huge: 64,
};

type IconProps = {
  icon: string;
  size?: keyof typeof iconSizes;
};

export default function Icon({ icon, size = "small" }: IconProps) {
  return (
    <label
      cssClasses={["icon", size]}
      label={icon}
      heightRequest={iconSizes[size]}
      widthRequest={iconSizes[size]}
      valign={Gtk.Align.CENTER}
    />
  );
}
