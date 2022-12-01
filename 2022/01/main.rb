def test
  """1000
2000
3000

4000

5000
6000

7000
8000
9000

10000
"""
end

def elf_totals(input)
  elves = []
  food  = []

  # Parsing (and bucketing)
  input.split("\n").each do |line|
    if line == ""
      elves << food
      food = []
    else
      food << line
    end
  end
  elves << food

  # Totalling 
  elves.map { |elf| elf.map(&:to_i).sum }
end

puzzle '1.1', mode: :count, input: :lines, answer: 74394 do |input, count|
  #max = 0
  #max_idx = 0
  #calorie_totals.each_with_index do |elf, idx|
  #  if elf > max
  #    max = elf
  #    max_idx = idx
  #  end
  #  puts "Elf #{idx + 1} ate #{elf} calories"
  #end
  #puts "---"
  #puts "Elf #{max_idx + 1} ate the most: #{max} calories"
  #puts calorie_totals.max.green

  # Finding the index of the elf with the highest calorie total
  puts "Elf #{elf_totals(input).each_with_index.max[1] + 1} ate the most calories:"
end

puzzle '1.2', mode: :count, input: :lines, answer: 212_836 do |input, count|
  puts elf_totals(input).sort.reverse.take(3).sum
end