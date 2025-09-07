import app from "ags/gtk4/app";
import { Astal, Gtk } from "ags/gtk4";
import Workspaces from "./workspaces";
import SystemTray from "./system-tray";
import Menu from "../menu";
import Time from "./time";

const WINDOW_NAME = "Bar";

export default function Bar() {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      name={WINDOW_NAME}
      namespace={WINDOW_NAME}
      class={WINDOW_NAME}
      heightRequest={48}
      monitor={0}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <centerbox
        valign={Gtk.Align.CENTER}
        orientation={Gtk.Orientation.HORIZONTAL}
      >
        <box $type="start" halign={Gtk.Align.START} spacing={8}>
          <Workspaces />
        </box>
        <box $type="center" halign={Gtk.Align.CENTER}>
          <Time />
        </box>
        <box $type="end" halign={Gtk.Align.END} spacing={8}>
          <SystemTray />
          <Menu />
        </box>
      </centerbox>
    </window>
  );
}
