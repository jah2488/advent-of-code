def test
  [
    "A Y",
    "B X",
    "C Z",
  ]
end

A = :rock
B = :paper
C = :scissors

X = :rock
Y = :paper
Z = :scissors

def lose = 0
def draw = 3
def win  = 6  

def move_mod(move)
  case move
  when X, A then 1
  when Y, B then 2
  when Z, C then 3
  end
end

def score(a, b)
  case [a, b]
  when [A, Y], [B, Z], [C, X] then win  + move_mod(b)
  when [A, X], [B, Y], [C, Z] then draw + move_mod(b)
  when [A, Z], [B, X], [C, Y] then lose + move_mod(b)
  else
    raise "impossible #{a} #{b}"
  end
end

def to_move(s)
  case s
  when "A" then A
  when "B" then B
  when "C" then C
  when "X" then X
  when "Y" then Y
  when "Z" then Z
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
  when [:rock, :win]      then Y
  when [:rock, :draw]     then X
  when [:rock, :lose]     then Z
  when [:paper, :win]     then Z
  when [:paper, :draw]    then Y
  when [:paper, :lose]    then X
  when [:scissors, :win]  then X
  when [:scissors, :draw] then Z
  when [:scissors, :lose] then Y
  else
    raise "impossible #{move.inspect} #{outcome.inspect}"
  end
end

puzzle '2.1', mode: :count, answer: 8933 do |input, sum|
  input.each do |round|
    elf_move, my_move = round.split(" ")
    points = score(to_move(elf_move), to_move(my_move))
    sum += points
  end
  sum
end

puzzle '2.2', mode: :count, answer: 11998 do |input, sum|
  input.each do |round|
    elf_move, round_outcome = round.split(" ")
    print "#{elf_move} #{round_outcome} -> "
    my_move = calculate_move(elf_move, round_outcome)
    print "#{my_move} ==>"
    points = score(to_move(elf_move), my_move)
    puts " #{points}"
    sum += points
  end
  sum
end