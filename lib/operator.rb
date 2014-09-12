require "car"

class String
    def is_i?
       !!(self =~ /\A[-+]?[0-9]+\z/)
    end
end

class Operator 
		def parse_position(text)
			points = text.split(',')

			if points.length != 3
				return nil
			elsif !points[0].is_i? or !points[1].is_i?
				return nil
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
					return nil
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
					return nil
				end
			end
		end
end
