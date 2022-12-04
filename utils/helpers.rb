require "pry"

$log = []
$results = [
    ["Puzzle", "Output", "Answer", "Calculation Time"],
]

def input(file_name, raw = false)
  file = File.open("#{$_year}/#{file_name}")
  return file.read if raw
  file.readlines
end

def test
  puts '--- TEST DATA BEING USED ---'.italic.yellow
  yield
end

def xpuzzle(name, mode: nil, input: nil, answer: nil) = nil

def puzzle(name, mode: :count, input: nil, answer: nil)
  dir = "0" + name.split(".").first
  file_name = [dir[-2..-1], "input.txt"].join("/")
  start_time = Time.now
  output = nil
  puts "---- starting  #{name} answer: #{answer} ----"
  case mode
  when :test
    puts "hii"
    binding.pry
  when :collection then output = yield(input(file_name, input), [])
  when :count      then output = yield(input(file_name, input), 0)
  when :find       then output = yield(input(file_name, input), false)
  when nil         then output = yield(input(file_name))
  else
    puts "Unknown mode: '#{mode}'"
    output = yield(mode)
  end
  puts answer
  if output == answer
    puts "---- output: ★ #{output.to_s.bold}".green + " ★ ----".green
  else
   puts "---- output: ◇ #{output.to_s.bold}".red + " ◇ ----".red
  end
  puts "---- finishing #{name} in: #{Time.now - start_time}s  ----"
  $results << [name, output, answer, Time.now - start_time]
  puts
end

at_exit {
  table($results, active_row: nil) do |row|
    row[1] == row[2]
  end
}

def copy(o)
  if o.respond_to?(:map)
    o.map { |xo| copy(xo) }
  else
    o.dup
  end
end

def debug_table(idx, **cols)
  w = (cols.keys.map(&:to_s).map(&:chomp).map { |x| x.rjust(4, " ") }.join(" | ") + " |").length + (cols.keys.length * 5)
  if idx.zero?
    puts "-" * w
    puts "|" + cols.keys.map(&:to_s).map(&:chomp).map { |x| x.rjust(10, " ") }.join(" | ")
    puts "-" * w
    puts "|" + cols.values.map(&:to_s).map(&:chomp).map { |x| x.rjust(10, " ") }.join(" | ")
  else
    puts "|" + cols.values.map(&:to_s).map(&:chomp).map { |x| x.rjust(10, " ") }.join(" | ")
    puts "-" * w
  end
end

def clear(direction = :up) = print "\033[#{direction == :up ? 1 : 2}J"
def floor = "═"
def wall  = "║"
def cross = "╬"
def corner_nw = "╔"
def corner_ne = "╗"
def corner_sw = "╚"
def corner_se = "╝"
def door_n = "╦"
def door_s = "╩"
def cnw = "┌"
def cne = "┐"
def csw = "└"
def cse = "┘"
def rounded_corner_nw = "╭"
def rounded_corner_ne = "╮"
def rounded_corner_sw = "╰"
def rounded_corner_se = "╯"
def smooth_wall = "│"
def smooth_floor = "─"
def lwall_join = "╠"
def rwall_join = "╣"
"═	║	╒	╓	╔	╕	╖	╗	╘	╙	╚	╛	╜	╝	╞	╟  ╠	╡	╢	╣	╤	╥	╦	╧	╨	╩	╪	╫	╬"
#╭	╮	╯	╰	╱	╲	╳	╴	╵	╶	╷	╸	╹	╺	╻	╼	╽	╾	╿	█	░	▒	▓	□	■	▲	▼	◆	◇	●	○	★	☆	♀	♂	♪	♫	♬	〓	〡	〢	〣	〤	〥	〦	〧	〨	〩	


def at(x:, y:)
  print "\033[s" #save cursor position
  print "\033[#{y};#{x}H" #move cursor to x,y
  yield
  print "\033[u" #restore cursor position
end


def box(width, height)
  puts cnw + smooth_floor * (width - 2) + cne
  (height - 2).times do
    puts smooth_wall + " " * (width - 2) + smooth_wall
  end
  puts csw + smooth_floor * (width - 2) + cse
end

def table(data, header: true, zebra: false, active_row: 1, cursor: ">")
  if active_row
    data = data.map.with_index { |row, idx| row.unshift(idx.zero? ? "#" : idx == active_row ? cursor : " ") }
  end
  col_widths = data.map { |row| row.map(&:to_s)
                   .map(&:length) }
                   .transpose
                   .map(&:max)
  puts corner_nw + col_widths.map { |w| floor * (w + 2) }.join(door_n) + corner_ne
  data.each.with_index do |row, row_idx|
    if row_idx.zero?
      puts wall + row.map.with_index { |cell, idx| cell.to_s.rjust(col_widths[idx] + 1, " ").ljust(col_widths[idx] + 2, " ").bold }.join(wall) + wall
      puts wall + row.map.with_index { |cell, idx| floor.to_s.rjust(col_widths[idx] + 1, floor).ljust(col_widths[idx] + 2, floor).bold }.join(cross) + wall
    else
      show_failure = false
      show_success = false
      if block_given?
        highlight = yield(row)
        show_failure = highlight == false
        show_success = highlight == true
      end
      if row_idx == active_row
        print "\033[48;2;#{125};#{125};#{125}m" 
        puts wall + row.map.with_index { |cell, idx| cell.to_s.rjust(col_widths[idx] + 1, " ").ljust(col_widths[idx] + 2, " ") }.join(wall) + wall
        print "\033[0m"
      elsif row_idx.even? && zebra
        print "\033[48;2;#{25};#{25};#{25}m" 
        print wall + row.map.with_index { |cell, idx| cell.to_s.rjust(col_widths[idx] + 1, " ").ljust(col_widths[idx] + 2, " ") }.join(wall) + wall
        puts "\033[0m"
      elsif show_success
        print "\033[48;2;#{125};#{255};#{125}m" 
        print wall + row.map.with_index { |cell, idx| cell.to_s.rjust(col_widths[idx] + 1, " ").ljust(col_widths[idx] + 2, " ") }.join(wall) + wall
        puts "\033[0m"
      elsif show_failure
        print "\033[48;2;#{255};#{125};#{125}m" 
        print wall + row.map.with_index { |cell, idx| cell.to_s.rjust(col_widths[idx] + 1, " ").ljust(col_widths[idx] + 2, " ") }.join(wall) + wall
        puts "\033[0m"
      else
        puts wall + row.map.with_index { |cell, idx| cell.to_s.rjust(col_widths[idx] + 1, " ").ljust(col_widths[idx] + 2, " ") }.join(wall) + wall
      end
    end
  end
  puts corner_sw + col_widths.map { |w| floor * (w + 2) }.join(door_s) + corner_se
end

def log(msg)
  $log ||= []
  $log << msg
end

def smooth_box(width, height)
  puts rounded_corner_nw + smooth_floor * (width - 2) + rounded_corner_ne
  (height - 2).times do
    puts smooth_wall + " " * (width - 2) + smooth_wall
  end
  puts rounded_corner_sw + smooth_floor * (width - 2) + rounded_corner_se
end

def box_shadow(level = 1)
  case level
  when 0 then " "
  when 1 then "░"
  when 2 then "▒"
  when 3 then "▓"
  when 4 then "█"
  else
    "X"
  end
end

def v_meter(value, max, height: 10, width: 2, color: :green)
  pct = (1 - value.to_f / max.to_f) * 100
  puts "max: #{max}, value: #{value}, pct: #{pct}"
  puts corner_nw + floor * (width) + corner_ne
  height.times do |n|
    if pct >= 10
      puts wall + box_shadow(0).public_send(color) * (width) + wall
    else
      if pct >= 7
        puts wall + box_shadow(1).public_send(color) * (width) + wall
      elsif pct >= 5
        puts wall + box_shadow(2).public_send(color) * (width) + wall
      elsif pct >= 2
        puts wall + box_shadow(3).public_send(color) * (width) + wall
      else
        puts wall + box_shadow(4).public_send(color) * (width) + wall
      end
    end
    pct -= 10
  end
  puts lwall_join + "".ljust(value.to_s.chars.length, floor) + rwall_join
  puts wall + value.to_s + wall
  puts corner_sw + floor * (width) + corner_se
end

def h_meter(value, max, width: 20, height: 1, color: :green)
  pct = (1 - value.to_f / max.to_f) * 100
  puts "max: #{max}, value: #{value}, pct: #{pct}"
  puts corner_nw + "".ljust(value.to_s.chars.length, floor) + door_n + floor * (width) + corner_ne
  print wall + value.to_s + wall
  width.times do |n|
    if pct >= 10
      print box_shadow(0).public_send(color)
    else
      if pct >= 7
        print box_shadow(1).public_send(color)
      elsif pct >= 5
        print box_shadow(2).public_send(color)
      elsif pct >= 2
        print box_shadow(3).public_send(color)
      else
        print box_shadow(4).public_send(color)
      end
    end
    pct -= 10
  end
  puts wall
  puts corner_sw + "".ljust(value.to_s.chars.length, floor) + door_s + floor * (width) + corner_se
end
class String
  def onoff(state, on, off)
    if state.respond_to?(:call)
      if state.call(self)
        self.public_send(on)
      else
        self.public_send(off)
      end
    else
      if state
        self.public_send(on)
      else
        self.public_send(off)
      end
    end
  end

  def at(x, y)
    "\033[#{x};#{y}H#{self}"
  end

  def shadow(level = 1)
    case level
    when 1 then "\033[48;2;#{25};#{25};#{25}m#{self}\033[0m"
    when 2 then "\033[48;2;#{50};#{50};#{50}m#{self}\033[0m"
    when 3 then "\033[48;2;#{75};#{75};#{75}m#{self}\033[0m"
    when 4 then "\033[48;2;#{100};#{100};#{100}m#{self}\033[0m"
    when 5 then "\033[48;2;#{125};#{125};#{125}m#{self}\033[0m"
    when 6 then "\033[48;2;#{150};#{150};#{150}m#{self}\033[0m"
    when 7 then "\033[48;2;#{175};#{175};#{175}m#{self}\033[0m"
    when 8 then "\033[48;2;#{200};#{200};#{200}m#{self}\033[0m"
    when 9 then "\033[48;2;#{225};#{225};#{225}m#{self}\033[0m"
    else
      "\033[48;2;#{25};#{25};#{25}m#{self}\033[0m"
    end
  end

  def bg_yellow
    "\033[43;1m#{self}\033[0m"
  end

  def bold
    "\033[1m#{self}\033[0m"
  end

  def italic
    "\033[3m#{self}\033[0m"
  end

  def black
    "\033[30m#{self}\033[0m"
  end

  def red(level = 1)
    "\033[31m#{self}\033[0m"
  end

  def green
    "\033[32m#{self}\033[0m"
  end

  def yellow
    "\033[33m#{self}\033[0m"
  end

  def blue
    "\033[34m#{self}\033[0m"
  end

  def purple
    "\033[35m#{self}\033[0m"
  end
end

class Integer
  def bold
    "\033[1m#{self}\033[0m"
  end

  def italic
    "\033[3m#{self}\033[0m"
  end

  def black
    "\033[30m#{self}\033[0m"
  end

  def red(level = 1)
    "\033[31m#{self}\033[0m"
  end

  def green
    "\033[32m#{self}\033[0m"
  end

  def yellow
    "\033[33m#{self}\033[0m"
  end

  def blue
    "\033[34m#{self}\033[0m"
  end

  def purple
    "\033[35m#{self}\033[0m"
  end
end
