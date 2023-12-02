// deno-lint-ignore-file
import { black, clamp, clear, fbox, log } from "../utils.ts";

/*
  STEP ONE:
    1abc2            12
    pqr3stu8vwx      38
    a1b2c3d4e5f      15
    treb7uchet       77

  STEP TWO:
    two1nine           29
    eightwothree       83
    abcone2threexyz    13
    xtwone3four        24
    4nineeightseven2   42
    zoneight234        14
    7pqrstsixteen      76
*/

const numbers = {
  "one": 1,
  "two": 2,
  "three": 3,
  "four": 4,
  "five": 5,
  "six": 6,
  "seven": 7,
  "eight": 8,
  "nine": 9,
  1: 1,
  2: 2,
  3: 3,
  4: 4,
  5: 5,
  6: 6,
  7: 7,
  8: 8,
  9: 9,
};

// o,   t,      f,       s,   e, n
// n, [w, h], [o, i], [i, e], i, i
// e, [o, r], [u, v], [x  v], g, n
// _   _  e   [r, e],  _  e,  h, e
// _   _  e    _  _    _  n,  t, _
// _   _  _    _  _    _  _   _  _

const stest = (str: string): string => {
  let left = null;
  let right = null;
  let buffer = "";

  for (let i = 0; i < str.length; i++) {
    buffer += str[i];
    if (str[i].match(/[0-9]/)) {
      left = str[i];
      break;
    }
    if (Object.keys(numbers).join("|").includes(buffer)) {
      if (left = numbers[buffer as keyof typeof numbers]) {
        break;
      }
    } else {
      buffer = buffer[1] || "";
    }
  }

  buffer = "";
  for (let i = str.length - 1; i >= 0; i--) {
    buffer = str[i] + buffer;
    if (str[i].match(/[0-9]/)) {
      right = str[i];
      break;
    }
    if (Object.keys(numbers).join("|").includes(buffer)) {
      if (right = numbers[buffer as keyof typeof numbers]) {
        break;
      }
    } else {
      buffer = buffer[0];
    }
  }
  return `${left}${right}`;
};

const test = (str: string): string => {
  const nums = "one 1 two 2 three 3 four 4 five 5 six 6 seven 7 eight 8 nine 9"
    .split(" ");
  let min = { index: 100, value: "0" };
  let max = { index: 0, value: "0" };
  nums.map((n) => {
    for (let i = 0; i < str.length; i++) {
      let window = str.slice(i, clamp(i + n.length, 0, str.length));
      if (window === n) {
        if (i < min.index) {
          min.index = i;
          min.value = n;
        }
        if (i > max.index) {
          max.index = i;
          max.value = n;
        }
      }
    }
  });

  return `${numbers[min.value as keyof typeof numbers]}${
    numbers[max.value as keyof typeof numbers]
  }`;
};

[
  ["two1nine", 29],
  ["eightwothree", 83],
  ["abcone2threexyz", 13],
  ["xtwone3four", 24],
  ["4nineeightseven2", 42],
  ["zoneight234", 14],
  ["7pqrstsixteen", 76],
  ["xsfmhnbdrj31828", 38],
  ["ninezrvbf717six", 96],
  ["7hlbhqxseven", 77],
  ["2jrvfr5lbqzfjgpdgfourthree7srmq", 27],
  ["6sixfive8nine", 69],
  ["eight29one", 81],
  ["onefour5ddgcrninedgdkzh1threesmcjmntnhh", 13],
  ["t4", 44],
  ["qrlmdjmkvvtwopdphfpmdd6fourxkblfqcx5", 25],
  ["62glckjgdvnpfourzlkphvrjffive", 65],
  ["nltxkzk2zhmqhfqq", 22],
  ["six22eight81ninepnscnlv", 69],
  ["eightfiveeightsevendxx1gh", 81],
  ["7nzlpbx864g5", 75],
  ["3eightlrrlgck967", 37],
  ["xcntwone4633sixmkm1nine", 29],
  ["478", 48],
  ["sixxxseven", 67],
  ["8two", 82],
  ["1eightwo", 12],
].forEach(([input, expected]) => {
  log(`${test(input as string)} should be ${expected} ${input}`);
});

Deno.readTextFile("./01/input.txt").then((data) => {
  let sum = 0;
  data.split("\n").forEach((line) => {
    const out = test(line);
    log(`${line} | ${out}`);
    sum += parseInt(out);
  });
  log("" + sum);
});
