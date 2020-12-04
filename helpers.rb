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
  file_name = [dir, "input.txt"].join("/")
  puts "---- starting  #{name} ----"
  case mode
  when :count then yield(input(file_name, input), 0)
  when :find then yield(input(file_name, input), false)
  else; yield(input(file_name))
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

class String
  def bold
    @_oldself = self if @oldself.nil?
    "\033[1m#{self}\033[0m"
  end

  def italic
    @_oldself = self if @oldself.nil?
    "\033[3m#{self}\033[0m"
  end

  def red
    @_oldself = self if @oldself.nil?
    "\033[31m#{self}\033[0m"
  end

  def green
    @_oldself = self if @oldself.nil?
    "\033[32m#{self}\033[0m"
  end
end
