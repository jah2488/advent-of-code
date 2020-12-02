f = File.open('input.txt').readlines

puts '------- starting 2.1 ---------'
i = 0
f.each do |row|
  results, _ = row.scan(/(\d+)-(\d+) (\D): (\D+)/)
  min, max, char, password = results

  valid = ((min.to_i)..(max.to_i)).cover?(password.gsub(/[^#{char}]/, '').length)
  m = valid ? "COR" : "ERR"
  puts <<EIF
     |---|------------------------------
     |#{m}| Password: '#{password.chomp}'
 #{i} |#{m}| Min: #{min}#{char} Max: #{max}#{char}
     |#{m}| Calc: #{password.gsub(/[^#{char}]/, '')} -> #{password.gsub(/[^#{char}]/, '').length}
EIF

  if password.count(char) <= max.to_i && password.count(char) >= min.to_i
    i += 1
  end
end
puts i

puts '------- starting 2.2 ---------'
i = 0
f.each do |row|
  results, _ = row.scan(/(\d+)-(\d+) (\D): (\D+)/)
  char_pos_a, char_pos_b, char, password = results

  a_match = password[char_pos_a.to_i - 1] == char
  b_match = password[char_pos_b.to_i - 1] == char

  m = a_match ^ b_match ? "COR" : "ERR"
  puts <<EIF
     |---|------------------------------
     |#{m}| Password: '#{password.chomp}'
 #{i} |#{m}| pos(#{char_pos_a})[#{password[char_pos_a.to_i - 1]}] == #{char}
     |#{m}| pos(#{char_pos_b})[#{password[char_pos_a.to_i - 1]}] == #{char}
EIF

  if m == "COR"
    i += 1
  end
end
puts i
