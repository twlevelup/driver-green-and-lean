require "car"

class Operator 
		
		def initialize

		end

		def set_location_instructions
			puts "Please enter a car location and orientation and instructions"
			STDOUT.flush

			input = STDIN.gets.chomp

			location = get_location(input)

			self.create_car(location[0], location[1], location[2])

			instructions = get_instruction(input)

			move_car(instructions) 

		end

	 	def get_position input

	 		points = input.split(/[\s,']/)

	 		x = points[0].to_i
			y = points[1].to_i
			orient = points[2].intern

			case orient

				when :N
					orientation = :north
				when :S
					orientation = :south
				when :E
					orientation = :east
				when :W
					orientation = :west
				else 
					return nil
			end						

			[x, y, orientation]

	 	end

	 	def get_instruction input


	 		points = input.split(/[\s,']/)

	 		if points.length != 4

	 			return nil

	 		end

	 		instructions = points[3].split('')

	 		instructions = instructions.map &:to_sym 

	 		return instructions 

	 	end

		def create_car(x, y, orientation)

			@car = Car.new(x, y, orientation)

			puts "New car created : #{@car.position} " 

			@car.position

		end


		def move_car(instructions)

			instructions.each do |instruction|

			case instruction
				when :F
					@car.move_forward
				when :B
					@car.move_backward
				when :L
					@car.turn_left
				when :R
					@car.turn_right
				else
					nil
			end

			end 
		end

end
