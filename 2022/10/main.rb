def test
  puts "--- Test Data In Use ---".italic.yellow
  [
    "addx 15",
    "addx -11",
    "addx 6",
    "addx -3",
    "addx 5",
    "addx -1",
    "addx -8",
    "addx 13",
    "addx 4",
    "noop",
    "addx -1",
    "addx 5",
    "addx -1",
    "addx 5",
    "addx -1",
    "addx 5",
    "addx -1",
    "addx 5",
    "addx -1",
    "addx -35",
    "addx 1",
    "addx 24",
    "addx -19",
    "addx 1",
    "addx 16",
    "addx -11",
    "noop",
    "noop",
    "addx 21",
    "addx -15",
    "noop",
    "noop",
    "addx -3",
    "addx 9",
    "addx 1",
    "addx -3",
    "addx 8",
    "addx 1",
    "addx 5",
    "noop",
    "noop",
    "noop",
    "noop",
    "noop",
    "addx -36",
    "noop",
    "addx 1",
    "addx 7",
    "noop",
    "noop",
    "noop",
    "addx 2",
    "addx 6",
    "noop",
    "noop",
    "noop",
    "noop",
    "noop",
    "addx 1",
    "noop",
    "noop",
    "addx 7",
    "addx 1",
    "noop",
    "addx -13",
    "addx 13",
    "addx 7",
    "noop",
    "addx 1",
    "addx -33",
    "noop",
    "noop",
    "noop",
    "addx 2",
    "noop",
    "noop",
    "noop",
    "addx 8",
    "noop",
    "addx -1",
    "addx 2",
    "addx 1",
    "noop",
    "addx 17",
    "addx -9",
    "addx 1",
    "addx 1",
    "addx -3",
    "addx 11",
    "noop",
    "noop",
    "addx 1",
    "noop",
    "addx 1",
    "noop",
    "noop",
    "addx -13",
    "addx -19",
    "addx 1",
    "addx 3",
    "addx 26",
    "addx -30",
    "addx 12",
    "addx -1",
    "addx 3",
    "addx 1",
    "noop",
    "noop",
    "noop",
    "addx -9",
    "addx 18",
    "addx 1",
    "addx 2",
    "noop",
    "noop",
    "addx 9",
    "noop",
    "noop",
    "noop",
    "addx -1",
    "addx 2",
    "addx -37",
    "addx 1",
    "addx 3",
    "noop",
    "addx 15",
    "addx -21",
    "addx 22",
    "addx -6",
    "addx 1",
    "noop",
    "addx 2",
    "addx 1",
    "noop",
    "addx -10",
    "noop",
    "noop",
    "addx 20",
    "addx 1",
    "addx 2",
    "addx 2",
    "addx -6",
    "addx -11",
    "noop",
    "noop",
    "noop",
  ] # 13140
end

def solve(input)
  signal_strength = 0
  cycle = 0
  x_reg = 1
  current_cmd = nil
  process_cmd = false
  cycle_history = []  
  cmd, val = nil, nil
  out = ""
  while input.any? do
    if current_cmd && process_cmd
      x_reg += val.to_i
      process_cmd = false
      current_cmd = nil
    end

    if current_cmd.nil?
      cmd, val = input.shift.split(' ')
      current_cmd = cmd
    else
      process_cmd = true
    end

    current_cmd = nil if cmd == "noop"

    cycle += 1

    log = "| #{cycle.to_s.rjust(3,"0")} |x:#{x_reg.to_s.rjust(3, " ")}| #{cmd} #{val.to_s.rjust(3, " ")}"

    if [x_reg - 1, x_reg, x_reg + 1].include?((cycle - 1) % 40)
      out += "█"
      log += "█".col((cycle % 40) + log.length)
    else
      out += " "
    end
    out += "\n" if ((cycle) % 40).zero?

    case cycle
    when  20, 60, 100, 140, 180, 220
      signal_strength += x_reg * cycle
    end
    cycle_history << log
    visualize(60.0, out)
  end
  puts corner_nw + floor * 42 + corner_ne
  puts wall + " " * 42 + wall
  print wall + " " + out.gsub("\n", " #{wall}\n#{wall} ")
  puts " " * 41 + wall
  puts corner_sw + floor * 42 + corner_se
  signal_strength
end

def char = [ "░", "▒", "▓", "█" ].sample
def static(width, height)
  o = ""
  (width * height).times do
    o += char
  end
  o.split('').each_slice(width).map(&:join)
end

def visualize(fps = 24.0, pixels = nil)
  content = static(40, 6).join("\n")
  content = content.chars.map.with_index { |c, i| pixels[i] ? pixels[i] : c }.join if pixels
  content = content.split("\n").join(" #{wall}\n#{wall} ")
  out = ""
  out << corner_nw + floor * 42 + corner_ne + "\n"
  out << wall + " " * 42 + wall + "\n"
  out << wall + " " + content + " " + wall + "\n"
  out << wall + " " * 42 + wall + "\n"
  out << corner_sw + floor * 42 + corner_se + "\n"
  clear
  puts out
  sleep 1.0 / fps
end

puzzle '10.1', mode: :count, answer: 11820 do |input, cycle|
  solve(input)
end

puzzle '10.2', mode: :count, answer: EPJBRKAH do |input, total|
  #Part 1 solves both part 1 and 2
end
