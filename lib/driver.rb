#! /usr/bin/env ruby

require_relative 'operator'
require 'readline'

operator = Operator.new

STDOUT.puts 'Enter your commands below, or press Control+C to quit.'

begin
	Readline.completion_proc = proc { nil } # Disable tab completion

	while input = Readline.readline('> ')
		Readline::HISTORY << input

		STDOUT.puts operator.run_input(input)
		STDOUT.puts
	end

rescue Interrupt
	# Don't need to do anything here, we just don't want to display the ugly error message.
	# We print a blank line so that whatever is printed to the console next starts on its own line.
	STDOUT.puts
end