
def hsl_to_rgb(h, s, l)
  if s.zero?
    r = g = b = l
  else
    hue_to_rgb = -> (p, q, t) do
      t += 1 if t < 0
      t -= 1 if t > 1
      return p + (q - p) * 6 * t if t < 1.0/6.0
      return q  if t < 1.0/2.0
      return p + (q - p) * (2.0/3.0 - t) * 6.0 if t < 1.0/6.0
      return p
    end
    q = l < 0.5 ? l * (1.0 + s) : l + s - l * s
    p = 2.0 * l - q
    r = hue_to_rgb.(p, q, h + 1.0/3.0)
    g = hue_to_rgb.(p, q, h)
    b = hue_to_rgb.(p, q, h - 1.0/3.0)
  end
  [(r * 255).round, (g * 255).round, (b * 255).round]
end

def gradient(f1, f2, f3, p1, p2, p3, c = 128, w = 127, l = 255)
  (0..255).each do |n|
   r = Math.sin(f1*n + p1) * w + c;
   g = Math.sin(f2*n + p2) * w + c;
   b = Math.sin(f3*n + p3) * w + c;
   print "\033[48;2;#{r.round.abs};#{g.round.abs};#{b.round.abs}m  #{[r.round.abs,g.round.abs,b.round.abs].join(',')}  \033[0m"
  end
end

range = 0..255

range.each do |n|
  # print "\033[38;5;#{n * 10}m|#{n * 10}|\033[0m" #Print color on text
  #print "\033[48;5;#{n}m  #{n}  \033[0m" #Print color on background
end

# puts
# (0..1).step(0.01).each do |h|
#   (0..1).step(0.01).each do |s|
#     (0..1).step(0.01).each do |l|
#       r, g, b = hsl_to_rgb(h, s, l)
#       #print full rgb color
#       #print "\033[38;2;#{r};#{g};#{b}m  #{[r,g,b].join(',')}  \033[0m"
#       #print "\033[48;2;#{r};#{g};#{b}m  #{[r,g,b].join(',')}  \033[0m"
#     end
#   end
# end

#gradient(1, 1, 1, 0, 2, 4, 126, 128, 28)
#gradient(0.3, 0.3, 0.3, 0, 2, 5, 126, 128, 28)

def rainbow(str, offset = 0)
  str.each_char.with_index do |c, i|
    print "\033[38;5;#{((9 + i) + offset) % 6}m#{c}\033[0m"
  end
end

# 10.times do |n|
#   sleep 0.2
#   system "clear"
#   rainbow("Hello World", n * 10)
# end

