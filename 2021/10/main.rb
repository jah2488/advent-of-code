require_relative '../helpers'

puzzle '10.1' do |input|
  score = 0
  input.each do |line|
    count = Hash.new { |h, k| h[k] = 0 }
    found = false
    line.chars.each do |c|
      system('clear')
      puts line
      puts count.inspect
      next if found
      if ['[', '(', '{', '<'].include?(c)
        count[c] += 1
      end

      if [']', ')', '}', '>'].include?(c)
        count[c] -= 1
        if count[c] < 0
          found = true
          case c
          when ')' then score += 3
          when ']' then score += 57
          when '}' then score += 1197
          when '>' then score += 24137
          else
            fail
          end
        end
      end
    end
  end
  puts score
end