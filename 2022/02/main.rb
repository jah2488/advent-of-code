def test
  [
    "A Y",
    "B X",
    "C Z",
  ]
end

def lose = 0
def draw = 3
def win  = 6  

def move_mod(move)
  case move
  when :rock     then 1
  when :paper    then 2
  when :scissors then 3
  end
end

def score(a, b)
  case [a, b]
  when [:rock, :paper], [:paper, :scissors], [:scissors, :rock] then win  + move_mod(b)
  when [:rock, :rock], [:paper, :paper], [:scissors, :scissors] then draw + move_mod(b)
  when [:rock, :scissors], [:paper, :rock], [:scissors, :paper] then lose + move_mod(b)
  else
    raise "impossible #{a} #{b}"
  end
end

def to_move(s)
  case s
  when "A", "X" then :rock
  when "B", "Y" then :paper
  when "C", "Z" then :scissors
  else
    raise "impossible #{s}"
  end
end

def to_outcome(s)
  case s
  when "X" then :lose
  when "Y" then :draw
  when "Z" then :win
  else
    raise "impossible #{s}"
  end
end

def calculate_move(move, outcome)
  case [to_move(move), to_outcome(outcome)]
  when [:rock,  :win], [:paper, :draw], [:scissors, :lose] then :paper
  when [:rock, :lose], [:paper,  :win], [:scissors, :draw] then :scissors
  when [:rock, :draw], [:paper, :lose], [:scissors,  :win] then :rock
  else
    raise "impossible #{move.inspect} #{outcome.inspect}"
  end
end

puzzle '2.1', mode: :count, answer: 8933 do |input, sum|
  input.map { |x| x.split(" ") }.each do |elf_move, my_move|
    sum += score(to_move(elf_move), to_move(my_move))
  end
  sum
end

puzzle '2.2', mode: :count, answer: 11998 do |input, sum|
  input.map { |x| x.split(" ") }.each do |elf_move, round_outcome|
    sum += score(to_move(elf_move), calculate_move(elf_move, round_outcome))
  end
  sum
end