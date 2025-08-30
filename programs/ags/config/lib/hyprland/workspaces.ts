import { Accessor, createState, Setter } from "ags";
import Hyprland from "gi://AstalHyprland";

type WorkspaceStatus = "active" | "inactive" | null;

export default class Workspaces {
  private hyprland = Hyprland.get_default();
  public activeWorkspaceId: Accessor<number>;
  private setActiveWorkspaceId: Setter<number>;

  constructor() {
    const [activeWorkspaceId, setActiveWorkspaceId] = createState(
      this.hyprland.focusedWorkspace.id,
    );
    this.activeWorkspaceId = activeWorkspaceId;
    this.setActiveWorkspaceId = setActiveWorkspaceId;
  }

  init() {
    this.hyprland.connect("event", (_, event, args) => {
      if (event === "workspacev2") {
        const workspace = Number(args.split(",")[0]);
        this.setActiveWorkspaceId(workspace);
      }
    });
  }

  goToWorkspace(workspaceId: number) {
    this.hyprland.dispatch("workspace", workspaceId.toString());
  }

  workspaceStatus(workspaceId: number): Accessor<WorkspaceStatus> {
    return this.activeWorkspaceId.as<WorkspaceStatus>((activeWorkspaceId) => {
      const workspace = this.hyprland
        .get_workspaces()
        .find((workspace) => workspace.id === workspaceId);

      if (!workspace) return null;
      if (workspace.id === activeWorkspaceId) return "active";
      return "inactive";
    });
  }
}
