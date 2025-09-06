import Hyprland from "../../lib/hyprland";
import { Gtk } from "ags/gtk4";
import Icon from "../icon";

const icons = [
  "utilities-terminal-symbolic",
  "system-file-manager-panel",
  "firefox-symbolic",
  "spotify-indicator",
  "applications-games-symbolic",
  "notes-panel",
  "1password-panel",
  "virtual-desktops",
  "discord-tray",
];

export default function Workspaces() {
  Hyprland.workspaces.init();

  return (
    <box class="workspaces" halign={Gtk.Align.CENTER} valign={Gtk.Align.CENTER}>
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
  const icon = icons[workspaceId - 1];

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
        onClicked={() => Hyprland.workspaces.goToWorkspace(workspaceId)}
      >
        {icon && (
          <Icon
            iconName={icon}
            background="none"
            size={24}
          />
        )}
      </button>
    </box>
  );
}
