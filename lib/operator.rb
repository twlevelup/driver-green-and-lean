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

		position = parse_position parts[0]
		instructions = parse_instruction parts[1]

		[position, instructions]
	end

	def parse_position(text)
		points = text.split(',')

		if points.length != 3
			raise InvalidInputException, "Starting position and orientation is not in a recognised format."
		elsif !points[0].is_i? or !points[1].is_i?
			raise InvalidInputException, "Starting position must be specifed as two whole numbers."
		end

		x = points[0].to_i
		y = points[1].to_i

		if not Grid.valid_position?(x, y)
			raise InvalidInputException, "Starting position (#{x}, #{y}) is not valid."
		end

		if ORIENTATION_NAMES_TO_SYMBOLS.has_key?(points[2])
			orientation = ORIENTATION_NAMES_TO_SYMBOLS[points[2]]
		else
			raise InvalidInputException, "Starting orientation '#{points[2]}' is not recognised."
		end

		[x, y, orientation]
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
