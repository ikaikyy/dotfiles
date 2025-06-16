import { Gtk } from "astal/gtk4";
import { Variable } from "astal";

const datetime = Variable("").poll(1000, "date '+%H:%M:%S - %d de %B'");

export default function Time() {
  return <label cssClasses={["time"]} label={datetime()} />;
}
