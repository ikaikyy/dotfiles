import { Variable } from "astal";
import IconButton from "../IconButton";
import powerMenuController from "../PowerMenu/controller";

export default function PowerMenuIconButton() {
  const cssClasses = Variable.derive(
    [powerMenuController.isVisible],
    (isVisible) => {
      const classes = ["power-menu-icon-button"];

      if (isVisible) {
        classes.push("active");
      }

      return classes;
    },
  );

  return (
    <IconButton
      cssClasses={cssClasses()}
      iconName="system-shutdown-symbolic"
      onButtonPressed={() => powerMenuController.toggle()}
    />
  );
}
