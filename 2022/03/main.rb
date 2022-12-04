def test
  [
    "vJrwpWtwJgWrhcsFMMfFFhFp",
    "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
    "PmmdzqPrVvPwwTWBwg",

    "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
    "ttgJtRGJQctTZtZT",
    "CrZsJsPPZsGzwwsLwLmpwMDw"
  ]
end

priorities = Array('a'..'z').concat(Array('A'..'Z'))

puzzle '3.1', mode: :count, answer: 8515 do |input, total|
  total = 0
  input.each do |line|
    a = line[0..((line.length / 2) -1)]
    b = line[(line.length / 2)..-1]
    dup = (a.chars & b.chars).first 
    total += 1 + priorities.find_index(dup) if priorities.find_index(dup)
  end
  total
end

puzzle '3.2', mode: :count, answer: 2434 do |input, total|
  total = 0
  input.each_slice(3) do |group|
    badge = (group[0].chars & group[1].chars & group[2].chars).first
    total += 1 + priorities.find_index(badge) if priorities.find_index(badge)
  end
  total
end
