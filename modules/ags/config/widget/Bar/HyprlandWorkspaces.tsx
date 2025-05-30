import { Gdk, Gtk } from "astal/gtk4";
import { Variable } from "astal";

import Hyprland from "gi://AstalHyprland";

const hyprland = Hyprland.get_default();

const activeWorkspace = Variable(0);

activeWorkspace.set(hyprland.focusedWorkspace.id);

hyprland.connect("event", (_, event, args) => {
  if (event === "workspacev2") {
    const workspace = Number(args.split(",")[0]);

    activeWorkspace.set(workspace);
  }
});

type WorkspaceProps = {
  workspaceID: number;
};

function changeWorkspace(workspaceID: number) {
  hyprland.dispatch("workspace", workspaceID.toString());
}

function Workspace({ workspaceID }: WorkspaceProps) {
  const cssClasses = Variable.derive([activeWorkspace], (activeWorkspace) => {
    const isEmpty = !hyprland
      .get_workspaces()
      .some(
        (workspace) =>
          workspace.id === workspaceID && workspace.clients.length > 0,
      );

    return [
      "hyprland-workspace",
      activeWorkspace === workspaceID ? "active" : "",
      isEmpty ? "empty" : "",
    ];
  });

  return (
    <box
      heightRequest={16}
      widthRequest={16}
      halign={Gtk.Align.CENTER}
      valign={Gtk.Align.CENTER}
    >
      <box
        cursor={Gdk.Cursor.new_from_name("pointer", null)}
        cssClasses={cssClasses()}
        hexpand={true}
        halign={Gtk.Align.CENTER}
        valign={Gtk.Align.CENTER}
        onButtonPressed={() => changeWorkspace(workspaceID)}
      />
    </box>
  );
}

export default function HyprlandWorkspaces() {
  return (
    <box
      cssClasses={["hyprland-workspace-list"]}
      halign={Gtk.Align.CENTER}
      valign={Gtk.Align.CENTER}
      hexpand_set={true}
      spacing={4}
    >
      {Array.from({ length: 9 }, (_, index) => (
        <Workspace workspaceID={index + 1} />
      ))}
    </box>
  );
}
