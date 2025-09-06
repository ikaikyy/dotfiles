import app from "ags/gtk4/app";
import { Astal, Gtk } from "ags/gtk4";
import Workspaces from "./workspaces";
import SystemTray from "./system-tray";
import MenuToggle from "../menu/toggle";

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
      <box halign={Gtk.Align.FILL} valign={Gtk.Align.CENTER}>
        <box halign={Gtk.Align.START} spacing={8}>
          <Workspaces />
        </box>
        <box halign={Gtk.Align.CENTER}></box>
        <box halign={Gtk.Align.END} spacing={8}>
          <SystemTray />
          <MenuToggle />
        </box>
      </box>
    </window>
  );
}
