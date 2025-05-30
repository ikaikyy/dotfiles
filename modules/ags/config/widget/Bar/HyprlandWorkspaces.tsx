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
  return (
    <box
      cursor={Gdk.Cursor.new_from_name("pointer", null)}
      cssClasses={[
        "hyprland-workspace",
        activeWorkspace.get() === workspaceID ? "active" : "",
      ]}
      onButtonPressed={() => changeWorkspace(workspaceID)}
    />
  );
}

export default function HyprlandWorkspaces() {
  return (
    <box
      cssClasses={["hyprland-workspace-list"]}
      valign={Gtk.Align.CENTER}
      spacing={8}
    >
      {activeWorkspace().as(() => {
        const workspaces = Array.from({ length: 9 }, (_, index) => (
          <Workspace workspaceID={index + 1} />
        ));

        return workspaces;
      })}
    </box>
  );
}
