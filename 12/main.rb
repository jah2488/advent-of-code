require_relative "../helpers"

puzzle "12" do |input|
  ship = {x: 0, y: 0, angle: 90}
  input.each do |line|
    cmd, num = nil
    line.match(/(.)(\d{1,3})/).then do |matches|
      cmd = matches[1]
      num = matches[2].to_i
    end
    case cmd
    when "N" then ship[:y] -= num
    when "E" then ship[:x] += num
    when "S" then ship[:y] += num
    when "W" then ship[:x] -= num
    when "L" then ship[:angle] -= num
    when "R" then ship[:angle] += num
    when "F"
      case ship[:angle] % 360
      when 0 then ship[:y] -= num
      when 90 then ship[:x] += num
      when 180 then ship[:y] += num
      when 270 then ship[:x] -= num
      end
    end
  end
  puts ship.inspect
end

def ctp(x, y)
  {d: Math.hypot(x, y), a: Math.tan(y / x)}
end

def ptc(d, a)
  a = a % 360
  {x: (d * Math.cos(a)).round(2), y: (d * Math.sin(a)).round(2)}
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

def b
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
  ship = {x: 0, y: 0, angle: 90, n: Complex(0, 0)}
  wayp = {x: 10.0, y: -1.0, angle: 0, distance: 14, n: Complex(10, -1)}
  input.each do |line|
    cmd, num = nil
    line.match(/(.)(\d{1,3})/).then do |matches|
      cmd = matches[1]
      num = matches[2].to_i
    end
    #  puts "ship %s (%s)" % [ship[:n].rect.inspect, ship[:n].polar.inspect]
    #  puts "waypoint %s (%s)" % [wayp[:n].rect.inspect, wayp[:n].polar.inspect]

    case cmd
    when "N" then wayp[:n] -= Complex(0, num)
    when "E" then wayp[:n] += Complex(num, 0)
    when "S" then wayp[:n] += Complex(0, num)
    when "W" then wayp[:n] -= Complex(num, 0)
    when "L"
      (num / 90).to_i.times do
        wayp[:n] *= -Complex::I
      end
    when "R"
      (num / 90).to_i.times do
        wayp[:n] *= Complex::I
      end
    when "F"
      num.times do
        ship[:n] += wayp[:n]
      end
    end
    print "---(#{cmd}#{num.to_s.rjust(3, " ")})  ("
    print "Ship[#{ship[:n].rect[0].round.to_s.rjust(6, " ")},#{ship[:n].rect[1].round.to_s.rjust(6, " ")}] at #{(ship[:n].polar[1] * (180 / Math::PI)).round.to_s.rjust(4, " ")}º"
    print ")  (Wp[#{wayp[:n].rect[0].round.to_s.rjust(3, " ")},#{wayp[:n].rect[1].round.to_s.rjust(3, " ")}] at #{(wayp[:n].polar[1] * (180 / Math::PI)).round.to_s.rjust(4, " ")}º"
    puts ")---"
  end
  puts
  print "Ship[#{ship[:n].rect[0].round(4).to_s.rjust(6, " ")},#{ship[:n].rect[1].round(4).to_s.rjust(6, " ")}] at #{(ship[:n].polar[1] * (180 / Math::PI)).round.to_s.rjust(4, " ")}º"
  print ")  (Wp[#{wayp[:n].rect[0].round(4).to_s.rjust(3, " ")},#{wayp[:n].rect[1].round(4).to_s.rjust(3, " ")}] at #{(wayp[:n].polar[1] * (180 / Math::PI)).round.to_s.rjust(4, " ")}º"
  puts ")---"
  puts [ship[:n].rect, ship[:n].rect.sum]
  binding.pry
end
