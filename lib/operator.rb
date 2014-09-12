require "car"
require "InvalidInputException"

class String
    def is_i?
       !!(self =~ /\A[-+]?[0-9]+\z/)
    end
end

class Operator 
		def parse_command(text)
			parts = text.split(' ')

			position = parse_position parts[0]
			commands = parse_instruction parts[1]

			[position, commands]
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

			case points[2]
				when 'N'
					orientation = :north
				when 'S'
					orientation = :south
				when 'E'
					orientation = :east
				when 'W'
					orientation = :west
				else
					raise InvalidInputException, "Starting orientation '#{orientation}' is not recognised."
			end

			return [x, y, orientation]
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
end
