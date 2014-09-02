require "car"

class Operator 

attr_reader :x, :y, :orientation
		
		def initialize

			@x
			@y
			@orientation
		end

		def set_location 
			puts "Please enter a car location and orientation"
			STDOUT.flush

			location = STDIN.gets.chomp

			points = location.split(',')

			@x = points[0]
			@y = points[1]
			@orientation = points[2]

			@x = @x.to_i
			@y = @y.to_i

			@orientation = @orientation.intern

			self.create_car(@x, @y, @orientation)

			[@x, @y, @orientation]

			end
	 

		def create_car(x, y, orientation)

			@car = Car.new(x, y, orientation)

			puts "New car created : #{@car.position} " 

		end

		def instruction_stack(car)

			puts "Please enter instructions for car:"

			instructions = STDIN.gets.chomp

			moves = instructions.split("")

			moves.each { |x| self.move_car?(x) }

			@car.position

		end

		def move_car?(instruction)

			@instruction = instruction.intern

			case @instruction
				when :F
					@car.move_forward
				when :B
					@car.move_backward
				when :L
					@car.turn_left
				when :R
					@car.turn_right
				end
		end

end
