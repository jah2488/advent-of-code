def test
  puts "--- Test Data In Use ---".italic.yellow
  #     [D]    
  # [N] [C]    
  # [Z] [M] [P]
  #  1   2   3 
  # 
  # move 1 from 2 to 1
  # move 3 from 1 to 3
  # move 2 from 2 to 1
  # move 1 from 1 to 2
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

puzzle '5.1', mode: :count, answer: "QNHWJVJZW" do |input, total|
  stacks = { }
  instructions = []
  input.each do |line|
    line.scan(/\[([A-Z])\]/) do |match|
      index = Regexp.last_match.begin(0)
      stack = (index / 4) + 1
      puts "Found #{match[0]} at #{index} in stack #{stack}"
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
  puts stacks
  puts instructions

  instructions.each do |ins|
    crates = stacks[ins[:from]].shift(ins[:crates])
    stacks[ins[:to]].unshift(*crates.reverse)
  end

  stacks.sort.map { |(k, v)| Array(v).first }.join
end

puzzle '5.2', mode: :count, answer: "BPCZJLFJW" do |input, total|
  stacks = { }
  instructions = []
  input.each do |line|
    line.scan(/\[([A-Z])\]/) do |match|
      index = Regexp.last_match.begin(0)
      stack = (index / 4) + 1
      puts "Found #{match[0]} at #{index} in stack #{stack}"
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
  puts stacks
  puts instructions

  instructions.each do |ins|
    crates = stacks[ins[:from]].shift(ins[:crates])
    stacks[ins[:to]].unshift(*crates)
  end

  puts stacks
  stacks.sort.map { |(k, v)| Array(v).first }.join
end
