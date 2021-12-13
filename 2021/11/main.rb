require_relative '../helpers'

def test
  [
    "5483143223\n",
    "2745854711\n",
    "5264556173\n",
    "6141336146\n",
    "6357385478\n",
    "4167524645\n",
    "2176841721\n",
    "6882881134\n",
    "4846848554\n",
    "5283751526\n",
  ]
end

def display(input, octo, step)
  out = "\n" 
  out << "--- #{step} ---"
  input.each.with_index do |line, lidx|
    out << "\n"
    line.each.with_index do |octopus, cidx|
      str = octopus.to_s

      if [lidx, cidx] == octo.location
        str = octopus.to_s.bg_yellow
      end

      if octo.energy == 9 && octo.is_neibour?(lidx, cidx)
        str = str.red
      end

      case octopus
      when 0 then str = str.yellow
      when 9 then str = str.bold
      else
        str = str
      end
      out << str
    end
  end
  puts out
end

Ns = 
[
  [-1, -1], [-1, 0], [-1,  1], 
  [ 0, -1],          [ 1, -1], 
  [ 1, -1], [ 1, 0], [ 1,  1],
]

class Consortium
  def initialize
    @col = {}
  end

  def as_grid
    @col.group_by { |(k, v)| k.first }.flat_map do |(row, v)|
      v.group_by { |(k, v)| k.first }.map do |(col, val)|
        val.map { |x| x.last.energy }
      end
    end
  end

  def add(octopus)
    octopus.consortium = self
    @col[octopus.location] = octopus
  end

  def step
    @col.each do |loc, octopus|
      octopus.step!
      yield octopus if block_given?
    end
  end


  def notify_neighbors(octopus)
    binding.pry if octopus.location == [0, 2]
    Ns
      .map { |n| @col[[octopus.location[0] + n[0], octopus.location[1] + n[1]]] }
      .compact
      .each { |neighbor| neighbor.charge! }
  end
end

class Octopus
  MAX_ENERGY = 9
  attr_reader :energy, :location
  attr_writer :consortium

  def initialize(n, x, y)
    @energy = n
    @location = [x, y]
    @locked = false
  end

  def is_neibour?(x, y)
    (location[0] - x).abs <= 1 && (location[1] - y).abs <= 1
  end

  def step!
    @locked = false
  end

  def charge!
    @energy += 1
    flash! if @energy > MAX_ENERGY
  end

  def flash!
    if @locked
      return
      @energy = MAX_ENERGY
    end
    @locked = true
    @consortium.notify_neighbors(self)
    @energy = 0
  end

  def inspect
    to_s
  end

  def to_s
    energy.to_s
  end
end

puzzle '11', mode: test do |input|
  system('clear')
  steps = 5
  con = Consortium.new
  grid = input.map { |line| line.chomp.split('').map(&:to_i) }
  grid.each.with_index do |row, x|
    row.map.with_index do |octopus, y|
      con.add Octopus.new(octopus, x, y)
    end
  end
  steps.times do |n|
    #puts con.as_grid.inspect

    con.step do |octopus|
      # system('clear')
     # display(con.as_grid, octopus, n + 1)
      octopus.charge!
      sleep 0.00212
    end
    display(con.as_grid, Octopus.new(-1, -1, -1), n + 1)

    puts $log
  end
end