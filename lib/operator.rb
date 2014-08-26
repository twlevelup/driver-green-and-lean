class Operator 

	def initialize()
		set_location
	end

	def set_location
		puts "Please enter a car location and orientation"
		STDOUT.flush
		location = gets.chomp
		puts "Car location is at " + location
	end

end
