import { App, Astal, Gtk } from "astal/gtk4";

import Icon from "../Icon";
import Time from "./Time";
import Battery from "./Battery";
import HyprlandWorkspaces from "./HyprlandWorkspaces";
import SystemTray from "./SystemTray";

const BAR_WINDOW_NAME = "Bar";

export default function Bar() {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      name={BAR_WINDOW_NAME}
      namespace={BAR_WINDOW_NAME}
      layer={Astal.Layer.TOP}
      visible={true}
      heightRequest={56}
      cssClasses={[BAR_WINDOW_NAME]}
      monitor={0}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <centerbox valign={Gtk.Align.CENTER}>
        <box spacing={12}>
          <Icon iconName="nix-snowflake" size={24} />
          <HyprlandWorkspaces />
        </box>
        <box spacing={12} valign={Gtk.Align.CENTER}>
          <Time />
        </box>
        <box spacing={12}>
          <SystemTray />
          <Battery />
        </box>
      </centerbox>
    </window>
  );
}
