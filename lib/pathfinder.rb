class Pathfinder
	ORIENTATIONS = [:north, :east, :south, :west]

	# This could be improved by moving backwards when the car is pointing the wrong way around.
	def generate_path(start_point, end_point)
		if start_point[0] == end_point[0] && start_point[1] == end_point[1]
			return []
		end

		x_diff = end_point[0] - start_point[0]
		y_diff = end_point[1] - start_point[1]
		current_orientation = start_point[2]

		path = []

		if x_diff > 0
			path.concat(turn_to_orientation(current_orientation, :east))
			path.concat([:move_forward] * x_diff)
			current_orientation = :east
		elsif x_diff < 0
			path.concat(turn_to_orientation(current_orientation, :west))
			path.concat([:move_forward] * -x_diff)
			current_orientation = :west
		end

		if y_diff > 0
			path.concat(turn_to_orientation(current_orientation, :north))
			path.concat([:move_forward] * y_diff)
		elsif y_diff < 0
			path.concat(turn_to_orientation(current_orientation, :south))
			path.concat([:move_forward] * -y_diff)
		end

		return path
	end

	def turn_to_orientation(current_orientation, target_orientation) 
		current_orientation = ORIENTATIONS.index(current_orientation)
		target_orientation = ORIENTATIONS.index(target_orientation)

		case (current_orientation - target_orientation)
			when 0
				# Don't need to do anything
				return []
			when 1
				return [:turn_left]
			when -1
				return [:turn_right]
			when 2, -2
				return [:turn_right, :turn_right]
			when 3
				return [:turn_right]
			when -3
				return [:turn_left]
		end
	end
end