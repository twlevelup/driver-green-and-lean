class Grid
	GRID_HEIGHT = 5
	GRID_WIDTH = 8

	def self.valid_position?(x, y)
  	if x < 0 or y < 0 or y > GRID_HEIGHT or x > GRID_WIDTH
			return false
		else
			return true
  	end
  end
end