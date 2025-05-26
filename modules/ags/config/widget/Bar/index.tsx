import { App, Astal, Gtk } from "astal/gtk4";

import Time from "./Time";
import HyprlandKeyboardLayout from "./HyprlandKeyboardLayout";
import HyprlandWorkspaces from "./HyprlandWorkspaces";
import { AppLauncherIconButton } from "../AppLauncher";

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
        <box spacing={12}>
          <AppLauncherIconButton />
          <HyprlandWorkspaces />
        </box>
        <box spacing={12}>
          <Time />
        </box>
        <box spacing={12}></box>
      </centerbox>
    </window>
  );
}
