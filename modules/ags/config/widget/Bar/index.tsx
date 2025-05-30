import { App, Astal, Gtk } from "astal/gtk4";

import Icon from "../Icon";
import Time from "./Time";
import HyprlandKeyboardLayout from "./HyprlandKeyboardLayout";
import HyprlandWorkspaces from "./HyprlandWorkspaces";

const BAR_WINDOW_NAME = "Bar";

export default function Bar() {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      name={BAR_WINDOW_NAME}
      namespace={BAR_WINDOW_NAME}
      layer={Astal.Layer.TOP}
      visible={true}
      heightRequest={48}
      cssClasses={[BAR_WINDOW_NAME]}
      monitor={0}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <centerbox valign={Gtk.Align.CENTER}>
        <box spacing={12}>
          <Icon iconName="nix-snowflake" size={32} />
          <HyprlandWorkspaces />
        </box>
        <box spacing={12}>
          <Time />
        </box>
        <box spacing={12}>
          <HyprlandKeyboardLayout />
        </box>
      </centerbox>
    </window>
  );
}
