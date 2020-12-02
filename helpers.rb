def input(file_name = "input.txt")
  File.open(file_name).readlines
end

def puzzle(name, mode: :count, file_name: "01/input.txt", answer: nil)
  puts "---- starting  #{name} ----"
  case mode
  when :count then yield(input(file_name), 0)
  when :find  then yield(input(file_name), false)
  else;            yield(input(file_name))
  end
  puts answer
  puts "---- finishing #{name} ----"
  puts
end
