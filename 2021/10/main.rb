require_relative '../helpers'

def box_display(char, count)
  o = ""
  o << corner_nw + floor * 2 + door_n + floor * count[char] + corner_ne + "\n"
  o << wall + "✖#{count[char]}".bold + wall + char * count[char] + wall + "\n"
  o << corner_sw + floor * 2 + door_s + floor * count[char] + corner_se + "\n"
  o
end

puzzle '10.1' do |input|
  width = 32
  score = 0
  input[0..1].each.with_index do |line, idx|
    count = Hash.new { |h, k| h[k] = 0 }
    found = false
    line.chomp.chars.each.with_index do |c, cidx|
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
      out << box_display("(", count)
      out << box_display("{", count)
      out << box_display("<", count)
      puts out
      next if found

      if ['[', '(', '{', '<'].include?(c)
        count[c] += 1
      end

      if [']', ')', '}', '>'].include?(c)
        if count[c] <= 0
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
      sleep 0.055
    end
  end
  puts score
end