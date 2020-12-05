require_relative "../helpers"

class Cursor
  attr_accessor :min, :max

  def self.with_max(max)
    Cursor.new.tap do |c|
      c.min = 0
      c.max = max
    end
  end

  def lower!
    self.max = mid.round
  end

  def higher!
    self.min = mid + 1
  end

  def mid
    ((max + min) / 2).round
  end
end

ROWS = 127
COLS = 7

puzzle "5.1 & 5.2", mode: :collection do |input, seat_ids|
  input.each do |pass|
    row = Cursor.with_max(ROWS)
    col = Cursor.with_max(COLS)
    pass.chomp.chars.each do |dir|
      case dir
      when "F" then row.lower!
      when "B" then row.higher!
      when "L" then col.lower!
      when "R" then col.higher!
      end
    end
    seat_id = row.max * 8 + col.max
    seat_ids << seat_id
  end
  my_seat = ((6..seat_ids.length).zip(seat_ids.sort).find { |(id, seat)| id != seat }).first

  puts "Highest ID: %s, My Seat ID: %s" % [seat_ids.max, my_seat]
end
