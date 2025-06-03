import { bind, Binding, Variable } from "astal";
import { Gdk, Gtk, astalify } from "astal/gtk4";

const GdkDisplay = Gdk.Display.get_default();

if (!GdkDisplay) {
  throw new Error("No Gdk Display found");
}

const IconTheme = Gtk.IconTheme.get_for_display(GdkDisplay);

export type IconProps = {
  iconName: string | Binding<string>;
  size?: number;
};

export default function Icon({ iconName, size }: IconProps) {
  if (typeof iconName === "string") {
    iconName = Variable(iconName)();
  }

  const GtkIconPaintable = iconName.as((iconName) =>
    IconTheme.lookup_icon(iconName, null, size || 16, 1, null, null),
  );

  const Image = astalify<Gtk.Image, Gtk.Image.ConstructorProps>(Gtk.Image);

  return (
    <box
      cssClasses={["icon"]}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.START}
    >
      <Image
        heightRequest={size}
        widthRequest={size}
        paintable={GtkIconPaintable}
      />
    </box>
  );
}
