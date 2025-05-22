import { App, Astal, Gtk } from "astal/gtk4";

import Time from "./Time";
import HyprlandKeyboardLayout from "./HyprlandKeyboardLayout";
import HyprlandWorkspaces from "./HyprlandWorkspaces";

export default function Bar() {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible={true}
      heightRequest={48}
      cssClasses={["Bar"]}
      monitor={0}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <centerbox valign={Gtk.Align.CENTER}>
        <box spacing={24}>
          <HyprlandWorkspaces />
        </box>
        <box spacing={24}>
          <Time />
        </box>
        <box spacing={24}></box>
      </centerbox>
    </window>
  );
}
