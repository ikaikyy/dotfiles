import { createBinding } from "ags";
import Notifd from "gi://AstalNotifd";

class Notifications {
  private readonly notifd = Notifd.get_default();

  public readonly notifications = createBinding(this.notifd, "notifications");

  public formatUrgency(urgency: Notifd.Urgency) {
    switch (urgency) {
      case 0:
        return "low";
      case 1:
        return "normal";
      case 2:
        return "critical";
      default:
        return "unknown";
    }
  }
}

export default new Notifications();
