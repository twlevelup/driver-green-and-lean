require_relative 'car'
require_relative 'InvalidInputException'

class String
    def is_i?
       !!(self =~ /\A[-+]?[0-9]+\z/)
    end
end

class Operator 
	ORIENTATION_NAMES_TO_SYMBOLS = {
		'N' => :north,
		'S' => :south,
		'E' => :east,
		'W' => :west
	}

	def parse_command(text)
		parts = text.split(' ')

		if parts.length != 2
			raise InvalidInputException, "Command is not in the required format."
		end

		position = parse_starting_position parts[0]
		instructions = parse_instruction parts[1]

		[position, instructions]
	end

	def parse_starting_position(text)
		points = text.split(',')

		if points.length != 3
			raise InvalidInputException, "Starting position and orientation is not in a recognised format."
		end

		coordinates = parse_position(points[0], points[1], 'Starting position')

		if ORIENTATION_NAMES_TO_SYMBOLS.has_key?(points[2])
			orientation = ORIENTATION_NAMES_TO_SYMBOLS[points[2]]
		else
			raise InvalidInputException, "Starting orientation '#{points[2]}' is not recognised."
		end

		[coordinates[0], coordinates[1], orientation]
	end

	def parse_destination(text)
		points = text.split(',')

		if points.length != 2
			raise InvalidInputException, "Ending position is not in a recognised format."
		end

		parse_position(points[0], points[1], 'Ending position')
	end

	def parse_position(x_string, y_string, type)
		if !x_string.is_i? or !y_string.is_i?
			raise InvalidInputException, "#{type} must be specifed as two whole numbers."
		end

		x = x_string.to_i
		y = y_string.to_i

		if not Grid.valid_position?(x, y)
			raise InvalidInputException, "#{type} (#{x}, #{y}) is not valid."
		end

		[x, y]
	end

	def parse_instruction(instructions)
		instructions_map = {
			'M' => :move_forward,
			'B' => :move_backward,
			'L' => :turn_left,
			'R' => :turn_right
		}

		instructions.split('').map do |instruction|
			instruction.upcase!

			if instructions_map.has_key?(instruction)
				instructions_map[instruction]
			else
				raise InvalidInputException, "Instruction '#{instruction}' is not recognised."
			end
		end
	end

	def run_input(input)
		begin
			parse_result = parse_command(input)
			position = parse_result[0]
			instructions = parse_result[1]

			car = Car.new(position[0], position[1], position[2])
			original_car = car.clone
			car.perform_commands(instructions)

			format_position_for_user(car)

		rescue InvalidInputException => e
			"Invalid input: #{e.message}\n" +
			"\n"+
			"Enter your command in the format (x),(y),(orientation) (commands), for example: 1,2,N MMRMMLB"

		rescue OutsideGridException => e
			"The taxi did not move because the commands would have caused it to move outside the boundary of the CBD.\n"+
			format_position_for_user(original_car)
		end
	end

	private
	def format_position_for_user(car)
		user_friendly_orientation = ORIENTATION_NAMES_TO_SYMBOLS.invert[car.orientation]

		"#{car.x},#{car.y},#{user_friendly_orientation}"
	end
end
