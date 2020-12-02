f = File.open('input.txt').readlines


puts "---- starting 1.1 ----"
found = nil
f.map(&:to_i).each do |n|
  break if found
  f.reverse.map(&:to_i).each do |x|
    break if found
    if n + x == 2020
      puts "(#{n}) + (#{x}) == 2020"
      puts n * x
      found = true
    end
  end
end

puts "---- starting 1.2 ----"
found = nil
f.map(&:to_i).each do |n|
  f.reverse.map(&:to_i).each do |x|
    next if x == n
    f.map(&:to_i).each do |z|
      next if z == x || z == n
      if n + x + z == 2020
        puts "(#{n}) + (#{x}) + (#{z}) == 2020"
        puts n * x * z
        exit
      end
    end
  end
end
