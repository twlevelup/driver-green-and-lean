#! /usr/bin/env ruby

require_relative 'operator'

operator = Operator.new

begin
	while true
		STDOUT.write '> '
		input = STDIN.gets

		STDOUT.puts operator.run_input(input)
		STDOUT.puts
	end
rescue Interrupt
	# Don't need to do anything here, we just don't want to display the ugly error message.
	# We print a blank line so that whatever is printed to the console next starts on its own line.
	STDOUT.puts
end