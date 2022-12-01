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

def elf_totals(input, elves = [], food = 0)
  input.split("\n").each do |line|
    if line == ""
      elves << food
      food = 0
    else
      food += line.to_i
    end
  end
  elves << food
end

puzzle '1.1', mode: :count, input: :lines, answer: 74_394 do |input, count|
  puts "Elf #{elf_totals(input).each_with_index.max[1] + 1} ate the most calories:" # This isn't required
  elf_totals(input).max
end

puzzle '1.2', mode: :count, input: :lines, answer: 212_836 do |input, count|
  elf_totals(input).sort[-3..-1].sum
end