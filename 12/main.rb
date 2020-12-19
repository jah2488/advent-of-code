require_relative "../helpers"

N = "N"
E = "E"
S = "S"
W = "W"
L = "L"
R = "R"
F = "F"

puzzle "12" do |input|
  ship = {x: 0, y: 0, angle: 90}
  input.each do |line|
    line.match(/(.)(\d{1,3})/).then do |matches|
      cmd = matches[1]
      num = matches[2].to_i
      case cmd
      when N then ship[:y] -= num
      when E then ship[:x] += num
      when S then ship[:y] += num
      when W then ship[:x] -= num
      when L then ship[:angle] -= num
      when R then ship[:angle] += num
      when F
        case ship[:angle] % 360
        when 0 then ship[:y] -= num
        when 90 then ship[:x] += num
        when 180 then ship[:y] += num
        when 270 then ship[:x] -= num
        end
      end
    end
  end
  puts ship.inspect, ship[:x].abs + ship[:y].abs
end

def a
  [
    "F10\n",
    "N3\n",
    "F7\n",
    "R90\n",
    "F11\n",
    "L90\n",
    "L90\n",
    "F11000\n",
    "L90\n",
    "L90\n",
    "F11000\n"
  ]
end

def debug
  [
    "F10\n",
    "R180\n",
    "F20\n",
    "L180\n",
    "F20\n",
    "R90\n",
    "R90\n",
    "F20\n",
    "L90\n",
    "L90\n",
    "F10\n"
  ]
end

puzzle "12.1" do |input|
  ship = Complex(0, 0)
  wayp = Complex(10, -1)
  input.each do |line|
    line.match(/(.)(\d{1,3})/).then do |matches|
      cmd = matches[1]
      num = matches[2].to_i
      case cmd
      when N then wayp -= Complex(0, num)
      when E then wayp += Complex(num, 0)
      when S then wayp += Complex(0, num)
      when W then wayp -= Complex(num, 0)
      when L then (num / 90).to_i.times { wayp *= -Complex::I }
      when R then (num / 90).to_i.times { wayp *= Complex::I }
      when F then num.times { ship += wayp }
      end
    end
  end
  puts [ship.rect.inspect, ship.rect.sum]
end
