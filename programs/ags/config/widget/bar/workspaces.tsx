import Hyprland from "../../lib/hyprland";
import { getIconPaintable } from "../../lib/icon-theme";
import { Gdk, Gtk } from "ags/gtk4";

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
]

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
  const iconPaintable = getIconPaintable(icon, 24);

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
      >
        {iconPaintable && (
          <image
            paintable={iconPaintable}
            heightRequest={24}
            widthRequest={24}
          />
        )}
      </button>
    </box>
  );
}
