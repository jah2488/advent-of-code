def test
  puts "--- Test Data In Use ---".italic.yellow
  "    [D]    \n[N] [C]    \n[Z] [M] [P]\n 1   2   3 \n\nmove 1 from 2 to 1\nmove 3 from 1 to 3\nmove 2 from 2 to 1\nmove 1 from 1 to 2\n".split("\n")
end

#[V]         [T]         [J]        
#[Q]         [M] [P]     [Q]     [J]
#[W] [B]     [N] [Q]     [C]     [T]
#[M] [C]     [F] [N]     [G] [W] [G]
#[B] [W] [J] [H] [L]     [R] [B] [C]
#[N] [R] [R] [W] [W] [W] [D] [N] [F]
#[Z] [Z] [Q] [S] [F] [P] [B] [Q] [L]
#[C] [H] [F] [Z] [G] [L] [V] [Z] [H]
# 1   2   3   4   5   6   7   8   9 
# 0   4   8  12  16  20  24  28  32

#     [D]    
# [N] [C]    
# [Z] [M] [P]
#  1   2   3 

# move 1 from 2 to 1
# move 3 from 1 to 3
# move 2 from 2 to 1
# move 1 from 1 to 2
def highlight(stacks, ins, state:)
  height = stacks.values.map(&:size).max
  h_crates = ins[:crates]
  clear
  output = ""
  output << "\n"
  until height <= 0 do
    stacks.sort.map do |(stack, crates)|
      if crates.size == height
        if ins[:from] == stack && h_crates > 0 && state == :before
          output << " [#{crates.shift}] ".col(stack * 4).red
        elsif ins[:to] == stack && h_crates > 0 && state == :after
          output << " [#{crates.shift}] ".col(stack * 4).green
        else
          output << " [#{crates.shift}] ".col(stack * 4)
        end
      end
    end
    h_crates -= 1
    height -= 1
    output << "\n"
  end
  stacks.sort.each do |(stack, crates)|
    if ins[:from] == stack && state == :before
      output << "  #{stack} ".col(stack * 4).yellow.bold
    elsif ins[:to] == stack && state == :after
      output << "  #{stack} ".col(stack * 4).yellow.bold
    else
      output << "  #{stack} ".col(stack * 4)
    end
  end
  output << "\n"
  output << corner_nw + floor * (stacks.size + 2) * 4 + corner_ne  + "\n"
  output << wall + " " + readable(ins).ljust((stacks.size + 2) * 6, " ") + " " + wall + "\n"
  output << corner_sw + floor * (stacks.size + 2) * 4 + corner_se + "\n"
  puts output
end

def visualize(stacks, ins, state:)  
  highlight(Hash[copy(stacks)], ins, state: state)
  sleep 0.12
end

def readable(ins)
  "move #{ins[:crates].bold} from #{ins[:from].bold} to #{ins[:to].bold}"
end

def solve(data, crane_version: 9000)
  stacks = { }
  instructions = []

  data.each do |line|
    line.scan(/\[([A-Z])\]/) do |match|
      index = Regexp.last_match.begin(0)
      stack = (index / 4) + 1
      stacks[stack] ||= []
      stacks[stack] << match[0]
    end
    line.scan(/move (\d+) from (\d+) to (\d+)/) do |match|
      instructions << { 
        crates: match[0].to_i,
        from:   match[1].to_i, 
        to:     match[2].to_i, 
      }
    end
  end

  gets
  instructions.each do |ins|
    visualize(stacks, ins, state: :before)
    crates = stacks[ins[:from]].shift(ins[:crates])
    crates = crates.reverse if crane_version == 9000
    stacks[ins[:to]].unshift(*crates)
    visualize(stacks, ins, state: :after)
  end

  stacks.sort.map { |(_, v)| Array(v).first }.join
end

puzzle '5.1', mode: :count, answer: "QNHWJVJZW" do |input, total|
  solve(input, crane_version: 9000)
end

xpuzzle '5.2', mode: :count, answer: "BPCZJLFJW" do |input, total|
  solve(input, crane_version: 9001)
end
