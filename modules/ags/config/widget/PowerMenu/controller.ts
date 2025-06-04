import { execAsync, Variable } from "astal";
import { App } from "astal/gtk4";

export const POWER_MENU_WINDOW_NAME = "PowerMenu";

export type PowerMenuAction =
  | "shutdown"
  | "reboot"
  | "lockScreen"
  | "logout"
  | null;

class PowerMenuController {
  readonly isVisible = Variable(false);
  readonly selectedAction = Variable<PowerMenuAction>(null);

  private shutdown() {
    this.hide();
    execAsync(["systemctl", "poweroff"]);
  }

  private reboot() {
    this.hide();
    execAsync(["systemctl", "reboot"]);
  }

  private lockScreen() {
    this.hide();
    execAsync(["hyprlock"]);
  }

  private logout() {
    this.hide();
    execAsync(["hyprctl", "dispatch", "exit"]);
  }

  selectAction(action: PowerMenuAction) {
    this.selectedAction.set(action);
  }

  confirmAction() {
    const action = this.selectedAction.get();

    if (!action) {
      throw new Error("Can't confirm action, no Action selected.");
    }

    this[action]();
  }

  cancelAction() {
    this.selectedAction.set(null);
  }

  show() {
    if (this.isVisible.get()) return;

    const window = App.get_window(POWER_MENU_WINDOW_NAME);

    if (window) {
      window.show();
      this.isVisible.set(true);
    }
  }

  hide() {
    if (!this.isVisible.get()) return;

    const window = App.get_window(POWER_MENU_WINDOW_NAME);

    if (window) {
      window.hide();
      this.isVisible.set(false);
      this.cancelAction();
    }
  }

  toggle() {
    if (this.isVisible.get()) {
      this.hide();
    } else {
      this.show();
    }
  }
}

const powerMenuController = new PowerMenuController();

export default powerMenuController;
