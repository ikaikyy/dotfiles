import Hyprland from "../../lib/hyprland";
import { Gdk, Gtk } from "ags/gtk4";

export default function Workspaces() {
  Hyprland.workspaces.init();

  return (
    <box
      class="workspaces"
      halign={Gtk.Align.CENTER}
      valign={Gtk.Align.CENTER}
      spacing={4}
    >
      {Array.from({ length: 9 }, (_, index) => (
        <Workspace workspaceId={index + 1} />
      ))}
    </box>
  );
}

type WorkspaceProps = {
  workspaceId: number;
};

function Workspace({ workspaceId }: WorkspaceProps) {
  return (
    <box
      heightRequest={16}
      widthRequest={16}
      halign={Gtk.Align.CENTER}
      valign={Gtk.Align.CENTER}
    >
      <button
        halign={Gtk.Align.CENTER}
        valign={Gtk.Align.CENTER}
        hexpand={true}
        class={Hyprland.workspaces
          .workspaceStatus(workspaceId)
          .as((status) => `workspace ${status}`)}
        cursor={Gdk.Cursor.new_from_name("pointer", null)}
        onClicked={() => Hyprland.workspaces.goToWorkspace(workspaceId)}
      />
    </box>
  );
}
