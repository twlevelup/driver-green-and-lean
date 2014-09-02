require "car"

class String
    def is_i?
       !!(self =~ /\A[-+]?[0-9]+\z/)
    end
end

class Operator 

		def set_location
		#1. read inputs 
			puts "Please enter a car location and orientation"
			STDOUT.flush

			location = STDIN.gets.chomp
		end

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

		def car_location
			#3. act on car
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
