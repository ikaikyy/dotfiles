import app from "ags/gtk4/app";
import { Astal, Gtk, Gdk } from "ags/gtk4";
import Workspaces from "./workspaces";
import SystemTray from "./system-tray";
import Icon from "../icon";

const WINDOW_NAME = "Bar";

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      name={WINDOW_NAME}
      namespace={WINDOW_NAME}
      class={WINDOW_NAME}
      heightRequest={48}
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <box halign={Gtk.Align.FILL} valign={Gtk.Align.CENTER}>
        <box halign={Gtk.Align.START} spacing={8}>
          <Icon iconName="nix-snowflake" />
          <Workspaces />
        </box>
        <box halign={Gtk.Align.CENTER}></box>
        <box halign={Gtk.Align.END}>
          <SystemTray />
        </box>
      </box>
    </window>
  );
}
