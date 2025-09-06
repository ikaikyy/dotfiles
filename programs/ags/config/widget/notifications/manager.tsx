import { For } from "ags";
import notifications from "../../lib/notifications";
import Notification from "./notification";
import Notifd from "gi://AstalNotifd";
import { Gtk } from "ags/gtk4";

export default function NotificationsManager() {
  return (
    <box
      class="notifications-manager"
      orientation={Gtk.Orientation.VERTICAL}
      spacing={8}
    >
      <label
        label="Notifications"
        class="notifications-manager-title"
        halign={Gtk.Align.START}
      />
      <For each={notifications.notifications}>
        {(notification: Notifd.Notification) => (
          <Notification notification={notification} />
        )}
      </For>
    </box>
  );
}
