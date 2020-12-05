require_relative "../helpers"

puzzle "5.1" do |input|
  max = 0
  seat_ids = []
  input.each do |pass|
    cmin = 0
    cmax = 127
    rmin = 0
    rmax = 7
    pass.chomp.chars.each do |dir|
      cmid = (cmax + cmin) / 2
      rmid = (rmax + rmin) / 2
      case dir
      when "F" then cmax = cmid.round
      when "B" then cmin = cmid.round + 1
      when "L" then rmax = rmid.round
      when "R" then rmin = rmid.round + 1
      end
      puts "|%s| (%3d, %3d) , (%1d, %1d)" % [dir, cmin, cmax, rmin, rmax]
    end
    seat_id = cmax * 8 + rmax
    puts seat_id
    seat_ids << seat_id
    max = seat_id if seat_id > max
  end
  puts max
  (6..900).zip(seat_ids.sort).each.with_index do |(id, seat), idx|
    print "|%3d| (%3d) (%3d)" % [idx, id, seat]
    if id != seat
      print "*" * 10
    end
    print "\n"
  end
end
