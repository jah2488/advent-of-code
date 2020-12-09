require_relative "../helpers"

# OldRange = (OldMax - OldMin)
# NewRange = (NewMax - NewMin)
# NewValue = (((OldValue - OldMin) * NewRange) / OldRange) + NewMin
# val = ((ran.length * newr) / oldr)
### print "| %d errors |#{"=" * val} (#{val})/(%d)" % [$errors, ran.length]
# max = $logs.max_by { |x| x.length }.length
# str = "[%3d]|%3s %1s%3d|%4d|%3s idx|"
# system("clear")
# oldr = (input.length - 0)
# newr = (100 - 0)
#
# log = Array.new(($logs.last || []).length)
# $logs.push(log)
# log << ["new", "", 0, 0, i]

OPS = {
  NOP: "nop",
  JMP: "jmp",
  ACC: "acc"
}

class Instr
  attr_accessor :op, :val, :add, :prv
  # div by 6 = 109

  def reset
    self.op = prv
  end

  def swap_op
    self.prv = op
    if op == OPS[:JMP]
      self.op = OPS[:NOP]
      self
    elsif op == OPS[:NOP]
      self.op = OPS[:JMP]
      self
    else
      self
    end
  end

  def to_s
    "|%4s| %s %+4d |" % [add, prv ? op.green : op, val]
  end
  alias_method :inspect, :to_s
end

class VM
  attr_accessor :acc, :program, :pointer, :trace

  def initialize
    @program = []
    @acc = 0
    @pointer = 0
    @trace = []
    @running = true
  end

  def terminated?
    @running == false
  end

  def reset_swapped_instructions
    program
      .select { |instr| [OPS[:NOP], OPS[:JMP]].include?(instr.op) && !instr.prv.nil? }
      .map!(&:reset)
  end

  def swap_next_instruction
    program.find { |instr| [OPS[:NOP], OPS[:JMP]].include?(instr.op) && instr.prv.nil? }.swap_op
  end

  def paths
    program.select { |instr| [OPS[:NOP], OPS[:JMP]].include?(instr.op) && instr.prv.nil? }.count
  end

  def repair
    instruction = program[pointer]

    if pointer >= program.length
      puts self
      exit
    end

    if trace.include?(instruction)
      puts "F-------------------F".red
      self.program = program.dup
      self.pointer = 0
      self.acc = 0
      self.trace = []
      reset_swapped_instructions
      swap_next_instruction
      return self
    end

    case instruction.op
    when OPS[:NOP]
      next_pointer = pointer + 1
    when OPS[:ACC]
      self.acc += instruction.val
      next_pointer = pointer + 1
    when OPS[:JMP]
      next_pointer = pointer + instruction.val
    else
      puts "err, unknown Op(%s)" % instruction.op
    end

    trace << instruction
    self.pointer = next_pointer
    self
  end

  def cycle
    instruction = program[pointer]
    if trace.include?(instruction)
      @running = false
      return self
    end

    case instruction.op
    when OPS[:NOP]
      next_pointer = pointer + 1
    when OPS[:ACC]
      self.acc += instruction.val
      next_pointer = pointer + 1
    when OPS[:JMP]
      next_pointer = pointer + instruction.val
    else
      puts "err, unknown Op(%s)" % instruction.op
    end

    trace << instruction
    self.pointer = next_pointer
    self
  end

  def to_s
    "VM(trc: %s, acc: %4s, ptr: %4s, pts: %d, itr: %s)" % [trace.length, acc, pointer, paths, program[pointer]]
  end
  alias_method :inspect, :to_s
end

def load(machine, input, i = 0)
  while i < input.length
    line = input[i].match(/(nop|acc|jmp) ((-|\+)\d{1,4})/)
    cmd = line[1]
    num = line[2].to_i

    instr = Instr.new.tap do |inst|
      inst.op = cmd
      inst.val = num
      inst.add = i + 1
    end

    machine.program << instr
    i += 1
  end
  machine
end

puzzle "8.1" do |input|
  machine = load(VM.new, input)
  puts machine.program
  until machine.terminated?
    # puts machine.cycle
    puts machine.repair
  end
end
