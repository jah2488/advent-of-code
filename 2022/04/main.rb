def test
  puts "--- Test Data In Use ---".italic.yellow
  [
    "2-4,6-8",
    "2-3,4-5",
    "5-7,7-9",
    "2-8,3-7",
    "6-6,4-6",
    "2-6,4-8"
  ]
end

puzzle '4.1', mode: :count, answer: 477 do |input, total|
  input.each do |line|
    section_a, section_b = line.split(',')
    section_a_min, section_a_max = section_a.split('-').map(&:to_i)
    section_b_min, section_b_max = section_b.split('-').map(&:to_i)
    a_range = (section_a_min..section_a_max)
    b_range = (section_b_min..section_b_max)
    total += 1 if (a_range.cover?(b_range) || b_range.cover?(a_range))
  end
  total
end

puzzle '4.2', mode: :count, answer: 830 do |input, total|
  input.each do |line|
    section_a, section_b = line.split(',')
    section_a_min, section_a_max = section_a.split('-').map(&:to_i)
    section_b_min, section_b_max = section_b.split('-').map(&:to_i)
    a_range = (section_a_min..section_a_max)
    b_range = (section_b_min..section_b_max)
    total += 1 if (
      a_range.include?(b_range.min) || a_range.include?(b_range.max) ||
      b_range.include?(a_range.min) || b_range.include?(a_range.max)
    )
  end
  total
end
