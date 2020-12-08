require_relative "../shared/arguments.rb"

Arguments.validate!(%w(file-path))

program = IO
  .read(ARGV[0])
  .split("\n")
  .map { _1.split(" ") }
  .map { [ _1, _2.to_i ] }

def run(program, step, accumulator, visited)
  return accumulator if step == program.length
  return if visited[step]
  visited[step] = true

  operation, argument = program[step]

  case operation
  when "acc" then run(program, step + 1, accumulator + argument, visited)
  when "jmp" then run(program, step + argument, accumulator, visited)
  when "nop" then run(program, step + 1, accumulator, visited)
  end
end

INSTRUCTION_UPDATES = { "jmp" => "nop", "nop" => "jmp", "acc" => "acc" }.freeze

program.each.with_index do |(old_operation, old_argument), index|

  updated_program = [
    *program[0...index],
    [ INSTRUCTION_UPDATES[old_operation], old_argument ],
    *program[(index + 1)..]
  ]

  result = run(updated_program, 0, 0, Array.new(program.length) { false })

  unless result.nil?
    puts result
    exit 0
  end
end
