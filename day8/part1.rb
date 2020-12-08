require_relative "../shared/arguments.rb"

Arguments.validate!(%w(file-path))

program = IO
  .read(ARGV[0])
  .split("\n")
  .map { _1.split(" ") }
  .map { [ _1, _2.to_i ] }

def run_until_loop(program, step, accumulator, visited)
  return accumulator if visited[step]
  visited[step] = true

  operation, argument = program[step]

  case operation
  when "acc" then run_until_loop(program, step + 1, accumulator + argument, visited)
  when "jmp" then run_until_loop(program, step + argument, accumulator, visited)
  when "nop" then run_until_loop(program, step + 1, accumulator, visited)
  end
end

puts run_until_loop(program, 0, 0, Array.new(program.length) { false })
