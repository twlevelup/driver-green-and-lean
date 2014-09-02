require "car"

class Operator 
		
		def initialize

		end

		def set_location_instructions
			puts "Please enter a car location and orientation and instructions"
			STDOUT.flush

			input = STDIN.gets.chomp

			x = @x.to_i
			y = @y.to_i

			orientation = @orientation.intern

			location = get_location(input)

			self.create_car(@x, @y, @orientation)

			instructions = get_instruction(input)

			end

	 	def get_location input

	 		points = input.split(/[\s,']/)

	 		x = points[0].to_i
			y = points[1].to_i
			orientation = points[2].intern

			[x, y, orientation]

	 	end

	 	def get_instruction input

	 		points = input.split(/[\s,']/)

	 		instructions = points[3]

	 		instructions.split("")
	 		
	 	end

		def create_car(x, y, orientation)

			@car = Car.new(x, y, orientation)

			puts "New car created : #{@car.position} " 

			@car.position

		end

		def instruction_stack(car)

			puts "Please enter instructions for car:"

			instructions = STDIN.gets.chomp

			moves = instructions.split("")

			moves.each { |x| self.move_car?(x) }

			@car.position

		end

		def move_car(instruction)

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
