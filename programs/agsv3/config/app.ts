import app from "ags/gtk4/app";
import style from "./styles/index.scss";
import Bar from "./widget/bar";

app.start({
  css: style,
  main() {
    app.get_monitors().map(Bar);
  },
});
