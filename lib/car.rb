class Car
	attr_reader :x, :y, :orientation

  def initialize(x, y, orientation)
  	if ![:north, :east, :south, :west].include?(orientation)
  		raise ArgumentError, 'Invalid orientation.'
  	end

  	@x = x
  	@y = y
  	@orientation = orientation
  end
    
  def move_forward
		case @orientation
	  	when :north
				@y = @y + 1
	  	when :south
				@y = @y - 1
	  	when :east
	  		@x = @x + 1
	  	when :west
	  		@x = @x - 1
  	end
  end

  def position
  	[@x, @y, @orientation]
  end
end
