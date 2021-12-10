require "pry"

def input(file_name, raw = false)
  if raw
    File.open(file_name).read
  else
    File.open(file_name).readlines
  end
end

def puzzle(name, mode: :count, input: nil, answer: nil)
  dir = "0" + name.split(".").first
  file_name = [dir[-2..-1], "input.txt"].join("/")
  puts "---- starting  #{name} ----"
  case mode
  when :test
    puts "hii"
    binding.pry
  when :collection then yield(input(file_name, input), [])
  when :count then yield(input(file_name, input), 0)
  when :find then yield(input(file_name, input), false)
  when nil then yield(input(file_name))
  else; yield(mode)
  end
  puts answer
  puts "---- finishing #{name} ----"
  puts
end

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

def clear
  print "\033[1J"
end

def floor
  "═"
end
def wall
  "║"
end
def cross
  "╬"
end
def corner_nw
  "╔"
end
def corner_ne
  "╗"
end
def corner_sw
"╚"
end
def corner_se
"╝"
end
def door_n
  "╦"
end
def door_s
  "╩"
end

"═	║	╒	╓	╔	╕	╖	╗	╘	╙	╚	╛	╜	╝	╞	╟  ╠	╡	╢	╣	╤	╥	╦	╧	╨	╩	╪	╫	╬"
#╭	╮	╯	╰	╱	╲	╳	╴	╵	╶	╷	╸	╹	╺	╻	╼	╽	╾	╿	█	░	▒	▓	□	■	▲	▼	◆	◇	●	○	★	☆	♀	♂	♪	♫	♬	〓	〡	〢	〣	〤	〥	〦	〧	〨	〩	㊣	㊤	㊥	㊦	㊧	㊨	㊩	㊪	㊫	㊬	㊭	㊮	㊯	㊰	㊱	㊲	㊳	㊴	㊵	㊶	㊷	㊸	㊹	㊺	㊻	㊼	㊽	㊾	㊿	㋀	㋁	㋂	㋃	㋄	㋅	㋆	㋇	㋈	㋉	㋊	㋋	㋌	㋍	㋎	㋏	㋐	㋑	㋒	㋓	㋔	㋕	㋖	㋗	㋘	㋙	㋚	㋛	㋜	㋝	㋞	㋟	㋠	㋡	㋢	㋣	㋤	㋥	㋦	㋧	㋨	㋩	㋪	㋫	㋬	㋭	㋮	㋯	㋰	㋱	㋲	㋳"

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
