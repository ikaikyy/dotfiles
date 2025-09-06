import { Gtk } from "ags/gtk4";
import notifications from "../../lib/notifications";
import Notifd from "gi://AstalNotifd";
import Pango from "gi://Pango";
import Icon from "../icon";

export type NotificationProps = {
  notification: Notifd.Notification;
};

export default function Notification({ notification }: NotificationProps) {
  const notificationTitle = `${notification.appName.charAt(0).toUpperCase()}${notification.appName.slice(1)} - ${notification.summary.charAt(0).toUpperCase()}${notification.summary.slice(1)}`;

  return (
    <box
      class={`notification urgency-${notifications.formatUrgency(notification.urgency)}`}
      orientation={Gtk.Orientation.VERTICAL}
      valign={Gtk.Align.CENTER}
      halign={Gtk.Align.START}
      widthRequest={400}
      heightRequest={180}
      spacing={4}
    >
      <box spacing={8} heightRequest={32}>
        <box halign={Gtk.Align.START} hexpand>
          <label
            class="notification-title"
            label={notificationTitle}
            singleLineMode
            maxWidthChars={32}
            ellipsize={Pango.EllipsizeMode.END}
          />
        </box>
        <box halign={Gtk.Align.END} valign={Gtk.Align.CENTER}>
          <button
            class="notification-close"
            onClicked={() => notification.dismiss()}
          >
            <Icon
              iconName="window-close-symbolic"
              background="none"
              size={16}
            />
          </button>
        </box>
      </box>
      <box spacing={8} halign={Gtk.Align.START} hexpand={true}>
        {notification.image ? (
          <box class="notification-image-container">
            <image
              file={notification.image}
              widthRequest={124}
              heightRequest={124}
              overflow={Gtk.Overflow.HIDDEN}
            />
          </box>
        ) : (
          <Icon
            iconName={notification.appIcon || "notifications"}
            background="rounded"
            size={124}
          />
        )}
        <Gtk.ScrolledWindow widthRequest={236} heightRequest={124}>
          <Gtk.TextView
            widthRequest={236}
            heightRequest={124}
            class="notification-body"
            wrapMode={Gtk.WrapMode.WORD_CHAR}
            cursorVisible={false}
            buffer={new Gtk.TextBuffer({ text: notification.body })}
          />
        </Gtk.ScrolledWindow>
      </box>
    </box>
  );
}
