require_relative 'car'
require_relative 'InvalidInputException'
require_relative 'pathfinder'

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

		if parts[1].include?(',')
			destination = parse_destination parts[1]
			pathfinder = Pathfinder.new()
			instructions = pathfinder.generate_path(position, destination)
		else
			instructions = parse_commands_list parts[1]
		end

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

		if not Grid.valid_position?(coordinates[0], coordinates[1])
			raise InvalidInputException, "Starting position (#{coordinates[0]}, #{coordinates[1]}) is not valid because it is outside the grid."
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

		[x, y]
	end

	def parse_commands_list(commands) 
		instructions_map = {
			'M' => :move_forward,
			'B' => :move_backward,
			'L' => :turn_left,
			'R' => :turn_right
		}

		commands.split('').map do |instruction|
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
			original_position = parse_result[0]
			instructions = parse_result[1]

			car = Car.new(original_position[0], original_position[1], original_position[2])
			positions = car.perform_commands(instructions)

			result = ''

			for position in positions
				result << format_position_for_user(position) + "\n"
			end

			result.chomp

		rescue InvalidInputException => e
			"Invalid input: #{e.message}\n" +
			"\n" +
			"Enter your command in the format (initial x coordinate),(initial y coordinate),(orientation) (commands), for example: 1,2,N MMRMMLB,\n" + 
			"or in the format (initial x coordinate),(initial y coordinate),(orientation) (destination x coordinate),(destination y coordinate)"

		rescue OutsideGridException => e
			"The taxi did not move because the instruction would have caused it to move outside the boundary of the CBD.\n" +
			format_position_for_user(original_position)
		end
	end

	private
	def format_position_for_user(position)
		user_friendly_orientation = ORIENTATION_NAMES_TO_SYMBOLS.invert[position[2]]

		"#{position[0]},#{position[1]},#{user_friendly_orientation}"
	end
end
