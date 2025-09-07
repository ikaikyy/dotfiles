import { Gtk } from "ags/gtk4";
import { createPoll } from "ags/time";

export default function Time() {
  const datetime = createPoll("", 1000, ["date", "+%a %d %b %X"]);
  return (
    <box class="time" halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER}>
      <label label={datetime} />
    </box>
  );
}
