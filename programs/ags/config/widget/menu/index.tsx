import app from "ags/gtk4/app";
import { Astal, Gtk } from "ags/gtk4";
import NotificationsManager from "../notifications/manager";

const WINDOW_NAME = "Menu";

export default function Menu() {
  const { TOP, RIGHT, BOTTOM } = Astal.WindowAnchor;

  return (
    <window
      visible={false}
      name={WINDOW_NAME}
      namespace={WINDOW_NAME}
      class={WINDOW_NAME}
      widthRequest={416}
      monitor={0}
      exclusivity={Astal.Exclusivity.NORMAL}
      layer={Astal.Layer.OVERLAY}
      anchor={TOP | RIGHT | BOTTOM}
      application={app}
    >
      <box orientation={Gtk.Orientation.VERTICAL} spacing={8}>
        <NotificationsManager />
      </box>
    </window>
  );
}
