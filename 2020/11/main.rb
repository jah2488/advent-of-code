require_relative "../helpers"
FLOOR = "."
SEAT = "L"
PERSON = "#"

def a
  [
    "L.LL.LL.LL\n",
    "LLLLLLL.LL\n",
    "L.L.L..L..\n",
    "LLLL.LL.LL\n",
    "L.LL.LL.LL\n",
    "L.LLLLL.LL\n",
    "..L.L.....\n",
    "LLLLLLLLLL\n",
    "L.LLLLLL.L\n",
    "L.LLLLL.LL\n"
  ]
end

def c
  neighbors_for(fill([
    ".......#.\n",
    "...#.....\n",
    ".#.......\n",
    ".........\n",
    "..#L....#\n",
    "....#....\n",
    ".........\n",
    "#........\n",
    "...#.....\n"
  ]), 4, 3)
end

def d
  neighbors_for(fill([
    ".............\n",
    ".L.L.#.#.#.#.\n",
    ".............\n"
  ]), 1, 1)
end

def e
  neighbors_for(fill([
    ".##.##.\n",
    "#.#.#.#\n",
    "##...##\n",
    "...L...\n",
    "##...##\n",
    "#.#.#.#\n",
    ".##.##.\n"
  ]), 3, 3)
end

def neighbors_for(seats, y, x)
  (-1..1).flat_map { |oy|
    (-1..1).map do |ox|
      next if oy.zero? && ox.zero?
      dir = [oy, ox]
      pos = [y, x]
      seat = seats[[pos[0] + dir[0], pos[1] + dir[1]]]
      until [PERSON, SEAT, nil].include? seat
        pos = [pos[0] + dir[0], pos[1] + dir[1]]
        seat = seats[[pos[0] + dir[0], pos[1] + dir[1]]]
      end
      [seat, [pos[0] + dir[0], pos[1] + dir[1]]]
    end
  }.compact.select { |s| s.first == PERSON }.count
end

def new_seat(seats, y, x)
  seat = seats[[y, x]]
  return PERSON if seat == SEAT && neighbors_for(seats, y, x).zero?
  return SEAT if seat == PERSON && neighbors_for(seats, y, x) >= 5
  seat
end

def iterate(seats)
  new_seats = {}
  new_seats[:max_y] = seats[:max_y]
  new_seats[:max_x] = seats[:max_x]
  (0..seats[:max_y]).each do |y|
    (0..seats[:max_x]).each do |x|
      new_seats[[y, x]] = new_seat(seats, y, x)
    end
  end
  new_seats
end

def display(seats)
  str = ""
  (0..seats[:max_y]).each do |y|
    (0..seats[:max_x]).each do |x|
      case seats[[y, x]]
      when SEAT then str += "⏣".purple
      when PERSON then str += "⏣".yellow
      when FLOOR then str += "⏣".green
      else
        "x"
      end
    end
    str += "\n"
  end
  puts "\e[H\e[2J"
  puts str
end

def fill(data)
  seats = {}
  seats[:max_y] = data.count
  seats[:max_x] = data.first.chomp.chars.count
  data.each.with_index do |row, ri|
    row.chomp.chars.each.with_index do |cell, ci|
      seats[[ri, ci]] = cell
    end
  end
  seats
end

puzzle "11" do |input|
  data = input
  seats = fill(data)
  old_seats = seats
  new_seats = nil
  until old_seats == new_seats
    old_seats = new_seats unless new_seats.nil?
    new_seats = iterate(old_seats)
    sleep 0.05
    display(new_seats)
  end
  puts new_seats.values.join.count(PERSON)
end
