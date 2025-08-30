import { Gdk, Gtk } from "ags/gtk4";

const gdkDisplay = Gdk.Display.get_default();

if (!gdkDisplay) {
  throw new Error("No default GDK display found");
}

export const iconTheme = Gtk.IconTheme.get_for_display(gdkDisplay);

export function getIconPaintable(iconName: string, size: number = 24) {
  if (iconTheme.has_icon(iconName)) {
    return iconTheme.lookup_icon(iconName, null, size, 1, null, null);
  }

  return iconTheme.lookup_icon("image-missing", null, size, 1, null, null);
}
