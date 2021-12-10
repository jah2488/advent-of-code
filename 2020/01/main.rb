require_relative '../../helpers.rb'

puzzle '1.1', mode: :find, answer: 1016131 do |input, found|
  input.each do |n|
    break if found
    input.reverse.each do |x|
      break if found
      if n.to_i + x.to_i == 2020
        puts n.to_i * x.to_i
        found = true
      end
    end
  end
end

puzzle '1.2', mode: :find, answer: 276432018 do |input, found|
  input.each do |n|
    break if found
    input.reverse.each do |x|
      break if found
      next if x == n
      input.each do |z|
        next if z == x || z == n
        if n.to_i + x.to_i + z.to_i == 2020
          puts n.to_i * x.to_i * z.to_i
          found = true
        end
      end
    end
  end
end
