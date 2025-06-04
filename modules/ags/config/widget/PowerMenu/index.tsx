import { App, Astal, Gdk, Gtk } from "astal/gtk4";

import powerMenuController, {
  POWER_MENU_WINDOW_NAME,
  PowerMenuAction,
} from "./controller";
import IconButton from "../IconButton";
import Icon from "../Icon";

const POWER_MENU_ACTIONS: {
  iconName: string;
  action: PowerMenuAction;
}[] = [
  {
    iconName: "system-shutdown-symbolic",
    action: "shutdown",
  },
  {
    iconName: "system-reboot-symbolic",
    action: "reboot",
  },
  {
    iconName: "system-lock-screen-symbolic",
    action: "lockScreen",
  },
  {
    iconName: "system-log-out-symbolic",
    action: "logout",
  },
];

const POWER_MENU_CONFIG = {
  iconSize: 96,
  spacing: 24,
  selectedActionIconSize: 216, // iconSize * 2 + spacing
};

function onKeyPressed(_, key: number) {
  switch (key) {
    case Gdk.KEY_Escape:
      powerMenuController.hide();
      break;

    default:
      break;
  }
}
export default function PowerMenu() {
  const { TOP, RIGHT, BOTTOM, LEFT } = Astal.WindowAnchor;

  return (
    <window
      application={App}
      name={POWER_MENU_WINDOW_NAME}
      namespace={POWER_MENU_WINDOW_NAME}
      cssClasses={[POWER_MENU_WINDOW_NAME]}
      layer={Astal.Layer.OVERLAY}
      anchor={TOP | RIGHT | BOTTOM | LEFT}
      exclusivity={Astal.Exclusivity.IGNORE}
      keymode={Astal.Keymode.EXCLUSIVE}
      monitor={0}
      visible={false}
      onKeyPressed={onKeyPressed}
      hexpand={true}
      vexpand={true}
    >
      <box
        cssClasses={["main"]}
        orientation={Gtk.Orientation.VERTICAL}
        halign={Gtk.Align.CENTER}
        valign={Gtk.Align.CENTER}
        spacing={POWER_MENU_CONFIG.spacing}
        hexpand={true}
        vexpand={true}
      >
        {powerMenuController.selectedAction().as((action) => {
          if (action) {
            return <PowerMenuConfirmation />;
          }

          return <PowerMenuActions />;
        })}
      </box>
    </window>
  );
}

function PowerMenuActions() {
  return (
    <box
      orientation={Gtk.Orientation.HORIZONTAL}
      spacing={POWER_MENU_CONFIG.spacing}
    >
      {POWER_MENU_ACTIONS.map((action) => (
        <IconButton
          iconName={action.iconName}
          size={POWER_MENU_CONFIG.iconSize}
          cssClasses={["power-menu-action"]}
          onButtonPressed={() =>
            powerMenuController.selectAction(action.action)
          }
        />
      ))}
      <IconButton
        iconName="gtk-close"
        size={POWER_MENU_CONFIG.iconSize}
        cssClasses={["power-menu-close-action"]}
        onButtonPressed={() => powerMenuController.hide()}
      />
    </box>
  );
}

function PowerMenuConfirmation() {
  const selectedActionIconName = POWER_MENU_ACTIONS.find(
    (a) => a.action === powerMenuController.selectedAction().get(),
  ).iconName;

  return (
    <>
      <Icon
        iconName={selectedActionIconName}
        size={POWER_MENU_CONFIG.selectedActionIconSize}
        cssClasses={["power-menu-confirmation-icon"]}
      />
      <box
        orientation={Gtk.Orientation.HORIZONTAL}
        spacing={POWER_MENU_CONFIG.spacing}
      >
        <IconButton
          iconName="gtk-no"
          size={POWER_MENU_CONFIG.iconSize}
          cssClasses={["power-menu-cancel-action"]}
          onButtonPressed={() => powerMenuController.cancelAction()}
        />
        <IconButton
          iconName="gtk-ok"
          size={POWER_MENU_CONFIG.iconSize}
          cssClasses={["power-menu-confirm-action"]}
          onButtonPressed={() => powerMenuController.confirmAction()}
        />
      </box>
    </>
  );
}
