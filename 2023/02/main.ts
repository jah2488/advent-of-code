import { fbox, log } from "../utils.ts";
const identity = <T>(t: T) => t;

const test = (
  max: { red: number; green: number; blue: number },
  str: string,
): number => {
  const diceSeen = {
    red: 0,
    green: 0,
    blue: 0,
  };
  const results = str
    .split(":")[1]
    .split(";")
    .map((s) => s.split(","));

  results.forEach((set) => {
    set.forEach((dice) => {
      const [amt, color] = dice.trim().split(" ");
      if (diceSeen[color as keyof typeof diceSeen] < parseInt(amt)) {
        diceSeen[color as keyof typeof diceSeen] = parseInt(amt);
      }
    });
  });

  return Object.values(diceSeen).reduce((a, b) => a * b, 1);

  // return ["red", "green", "blue"].map((color) => {
  //     const key = color as keyof typeof diceSeen;
  //     return diceSeen[key] <= max[key] ? false : true;
  //   }).filter(identity).length === 0
  //   ? "true"
  //   : "false";
};

const printObject = (obj: Record<string, unknown>) => {
  Object.keys(obj).forEach((key) => {
    log(`${key}: ${obj[key as keyof typeof obj]}`);
  });
};

[
  ["Game 1: 3 blue, 4 red; 1 red, 2 green, 6 blue; 2 green", true],
  ["Game 2: 1 blue, 2 green; 3 green, 4 blue, 1 red; 1 green, 1 blue", true],
  [
    "Game 3: 8 green, 6 blue, 20 red; 5 blue, 4 red, 13 green; 5 green, 1 red",
    false,
  ],
  [
    "Game 4: 1 green, 3 red, 6 blue; 3 green, 6 red; 3 green, 15 blue, 14 red",
    false,
  ],
  ["Game 5: 6 red, 1 blue, 3 green; 2 blue, 1 red, 2 green", true],
].map(([input, expected]) => {
  const result = test({
    red: 12,
    green: 13,
    blue: 14,
  }, input as string);

  log(`${result} should be ${expected} | ${"."}`);
});

Deno.readTextFile("./02/input.txt").then((data) => {
  let sum = 0;
  data.split("\n").forEach((game, index) => {
    const out = test({
      red: 12,
      green: 13,
      blue: 14,
    }, game);

    sum += out;
  });
  log("" + sum);
});
