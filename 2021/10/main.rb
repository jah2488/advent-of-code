require_relative '../helpers'

def box_display(char, count)
  o = ""
  o << corner_nw + floor * 3 + door_n + floor * count[char] + corner_ne + "\n"
  o << wall + "✖#{count[char]}".ljust(3, ' ') + wall + char * count[char] + wall + "\n"
  o << corner_sw + floor * 3 + door_s + floor * count[char] + corner_se + "\n"
  o
end

def open?(c)
  ["[", "{", "(", "<"].include?(c)
end

def close?(c)
  ["]", "}", ")", ">"].include?(c)
end

def match?(c1, c2)
  brace_pair(c1) == c2 && brace_pair(c2) == c1
end

def brace_pair(char)
  {
    "{" => "}",
    "}" => "{",
    "[" => "]",
    "]" => "[",
    "(" => ")",
    ")" => "(",
    ">" => "<",
    "<" => ">",
  }[char]
end

def test
  [
    "[({(<(())[]>[[{[]{<()<>>\n",
    "[(()[<>])]({[<{<<[]>>(\n",
    "{([(<{}[<>[]}>{[]{[(<()>\n",
    "(((({<>}<{<{<>}{[]{[]{}\n",
    "[[<[([]))<([[{}[[()]]]\n",
    "[{[{({}]{}}([{[{{{}}([]\n",
    "{<[[]]>}<{[{[{[]{()[[[]\n",
    "[<(<(<(<{}))><([]([]()\n",
    "<{([([[(<>()){}]>(<<{{\n",
    "<{([{{}}[<[[[<>{}]]]>[]]\n"
  ]
end

puzzle '10.1'do |input|
  width = 32
  score = 0
  part2 = []
  input.each.with_index do |line, idx|
    found = false
    count = Hash.new { |h, k| h[k] = 0 }
    stack = []
    line.chomp.chars.each.with_index do |c, cidx|
      if cidx == line.chomp.chars.length - 1 && found == false
        log "line #{idx} is incomplete...auto-completing"
        stack.pop
        closers = []
        until stack.empty?
          closers.push(brace_pair(stack.pop))
        end
        score = closers.reduce(0) do |s, c| 
          (s * 5) + (case c
          when ')' then 1
          when ']' then 2
          when '}' then 3
          when '>' then 4
          end)
        end
        part2 << score
        log "auto-complete: #{closers.join} score: #{score}"
      end
      prev = 15 
      prev_stop = cidx
      if cidx < prev
        prev = 0
        prev_stop = 15
      else
        prev = cidx - prev
      end
      if prev_stop < prev 
        prev_stop = prev
      end
      upnext = cidx + 15
      if upnext > line.length
        upnext = line.length - 1
      end
      system('clear')
      out = "Line: #{idx}\n"
      out << "prev: #{prev}-#{prev_stop} upnext: #{cidx + 1}-#{upnext}\n"
      out << "stack: #{stack.join}\n"
      out << "current: #{c}\n"
      out << "corrupted: #{found.inspect}\n"
      out << corner_nw + floor * 16 + door_n + floor + door_n + floor * 15 + corner_ne + "\n"
      out << wall
      out << line[prev..prev_stop].black 
      out << wall
      out << "#{c}".bg_yellow.bold
      out << wall
      out << line[(cidx + 1)..upnext].chomp.bold.ljust(23, ' ')
      out << wall + "\n"
      out << corner_sw + floor * 16 + door_s + floor + door_s + floor * 15 + corner_se + "\n"
      out << box_display("[", count)
      out << box_display("]", count)
      out << box_display("(", count)
      out << box_display(")", count)
      out << box_display("{", count)
      out << box_display("}", count)
      out << box_display("<", count)
      out << box_display(">", count)
      puts out
      puts "Score: #{score}"
      next if found

      count[c] += 1

      if open?(c)
        stack.push(c)
      end

      if close?(c)
        if match?(stack.last, c)
          stack.pop
        else
          # log "line #{idx} corrupted; failed to match '#{stack.last}' with '#{c}'"
          case c
          when ')' then score += 3
          when ']' then score += 57
          when '}' then score += 1197
          when '>' then score += 25137
          end
          found = true
        end
      end

      if [']', ')', '}', '>'].include?(c)
        if count[c] < count[brace_pair(c)]
          # found = true
          # case c
          # when ')' then score += 3
          # when ']' then score += 57
          # when '}' then score += 1197
          # when '>' then score += 25137
          # else
          #   fail
          # end
        end
      end
      #sleep 0.190055
    end
  end
  puts score
  puts $log
  part2.sort.each.with_index do |s, i|
    if i > (part2.length / 2 - 2) && i < (part2.length / 2 + 2)
      if part2.length / 2 == i
        puts "#{i - part2.length}: #{s}".red
      else
        puts "#{i - part2.length}: #{s}".green
      end
    else
      puts "#{i - part2.length}: #{s}".black
    end
  end
end