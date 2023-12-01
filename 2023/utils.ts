// deno-lint-ignore-file no-control-regex
// deno-lint-ignore-file no-unused-functions

const log = (msg: string): void => console.log(msg);
const clear = (direction: string = "up"): void =>
  console.log(`\x1b[${direction === "up" ? 1 : 2}J`);

const cursor = (x: number, y: number): void => console.log(`\x1b[${y};${x}H`);

const cursor_up = (n: number): void => console.log(`\x1b[${n}A`);
const cursor_down = (n: number): void => console.log(`\x1b[${n}B`);
const cursor_forward = (n: number): void => console.log(`\x1b[${n}C`);
const cursor_back = (n: number): void => console.log(`\x1b[${n}D`);
const cursor_next_line = (n: number): void => console.log(`\x1b[${n}E`);
const cursor_prev_line = (n: number): void => console.log(`\x1b[${n}F`);
const erase_line = (): void => console.log(`\x1b[K`);

const thick = {
  floor: "═",
  wall: "║",
  corner_nw: "╔",
  corner_ne: "╗",
  corner_sw: "╚",
  corner_se: "╝",
  door_n: "╦",
  door_s: "╩",
  cross: "╬",
  lwall_join: "╠",
  rwall_join: "╣",
};
const square = {
  floor: "─",
  wall: "│",
  corner_nw: "┌",
  corner_ne: "┐",
  corner_sw: "└",
  corner_se: "┘",
  door_n: "┬",
  door_s: "┴",
  cross: "┼",
  lwall_join: "├",
  rwall_join: "┤",
};
const rounded = {
  floor: "─",
  wall: "│",
  corner_nw: "╭",
  corner_ne: "╮",
  corner_sw: "╰",
  corner_se: "╯",
  door_n: "┬",
  door_s: "┴",
  cross: "┼",
  lwall_join: "├",
  rwall_join: "┤",
};

type Style = typeof thick | typeof square | typeof rounded;

const smooth_floor = "▒";
const smooth_wall = "▓";

const clamp = (n: number, min: number, max: number = 999999): number => {
  if (n < min) return min;
  if (n > max) return max;
  return n;
};

const remove_ansi = (s: string): string =>
  s.replace(
    /(\x9B|\x1B\[)[0-?]*[ -\/]*[@-~]/g,
    "",
  );

const box = (
  outerWidth: number,
  outerHeight: number,
  cb: () => string,
  style: Style = thick,
): void => {
  const width = outerWidth - 4;
  const height = outerHeight - 2;
  const padding = " ".repeat(
    clamp(((width - 2) / 2) - (remove_ansi(cb()).length / 2), 1),
  );

  log(style.corner_nw + style.floor.repeat(width - 2) + style.corner_ne);
  for (let i = 0; i < height; i++) {
    log(
      style.wall +
        padding +
        (cb()) +
        padding +
        style.wall,
    );
  }
  log(style.corner_sw + style.floor.repeat(width - 2) + style.corner_se);
};

const fbox = (cb: () => string, style: Style = thick): void => {
  const { columns } = Deno.consoleSize();
  box(columns, 3, cb, style);
};

const bg_yellow = (o: string | number): string => `\x1b[43;1m${o}\x1b[0m`;
const bg_red = (o: string | number): string => `\x1b[41;1m${o}\x1b[0m`;
const bg_green = (o: string | number): string => `\x1b[42;1m${o}\x1b[0m`;
const bg_blue = (o: string | number): string => `\x1b[44;1m${o}\x1b[0m`;
const bg_purple = (o: string | number): string => `\x1b[45;1m${o}\x1b[0m`;

const bold = (o: string | number): string => `\x1b[1m${o}\x1b[0m`;
const italic = (o: string | number): string => `\x1b[3m${o}\x1b[0m`;
const black = (o: string | number): string => `\x1b[30m${o}\x1b[0m`;
const red = (o: string | number): string => `\x1b[31m${o}\x1b[0m`;
const green = (o: string | number): string => `\x1b[32m${o}\x1b[0m`;
const yellow = (o: string | number): string => `\x1b[33m${o}\x1b[0m`;
const blue = (o: string | number): string => `\x1b[34m${o}\x1b[0m`;
const purple = (o: string | number): string => `\x1b[35m${o}\x1b[0m`;

const rainbowify = (s: string): string => {
  const colors = [red, yellow, green, blue, purple];
  let i = 0;
  return s
    .split("")
    .map((c) => colors[i++ % colors.length](c))
    .join("");
};

const rainbowify_bg = (s: string): string => {
  const colors = [bg_red, bg_yellow, bg_green, bg_blue, bg_purple];
  let i = 0;
  return s
    .split("")
    .map((c) => colors[i++ % colors.length](c))
    .join("");
};

const vertical_bar = (n: number): string => {
  const bar = "▁▂▃▄▅▆▇█";
  const i = Math.floor(clamp(n, 0, 1) * (bar.length - 1));
  return bar[i];
};

const horizontal_bar = (n: number): string => {
  const bar = "▏▎▍▌▋▊▉█";
  const i = Math.floor(clamp(n, 0, 1) * (bar.length - 1));
  return bar[i];
};

const new_screen = (): void => {
  clear();
  cursor(0, 0);
};
