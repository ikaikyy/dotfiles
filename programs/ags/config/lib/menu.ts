import app from "ags/gtk4/app";
import { Accessor, createState, Setter } from "ags";

export const MENU_WINDOW_NAME = "Menu";

class Menu {
  public readonly windowName = MENU_WINDOW_NAME;

  public readonly isVisible: Accessor<boolean>;
  private readonly setIsVisible: Setter<boolean>;

  constructor() {
    const [isVisible, setIsVisible] = createState(false);

    this.isVisible = isVisible;
    this.setIsVisible = setIsVisible;
  }
  public toggleVisibility() {
    const isVisible = this.isVisible.get();
    this.setIsVisible(!isVisible);

    const window = app.get_window(this.windowName);
    if (!window) throw new Error("Menu window not found");

    if (isVisible) window.hide();
    else window.show();
  }
}

export default new Menu();
