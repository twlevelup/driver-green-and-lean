require_relative 'OutsideGridException'
require_relative 'InvalidCommandException'
require_relative 'grid'

class Car
	attr_reader :x, :y, :orientation

  def initialize(x, y, orientation)
  	if ![:north, :east, :south, :west].include?(orientation)
  		raise ArgumentError, 'Invalid orientation.'
  	end

		validate_position(x, y, 'Starting position outside grid.') 

  	@x = x
  	@y = y
  	@orientation = orientation
  end
    
  def move_forward
  	move_distance(1)
  end

  def move_backward
  	move_distance(-1)
  end

  def turn_left
    case @orientation
      when :north
        @orientation = :west
      when :south
        @orientation = :east
      when :east
        @orientation = :north
      when :west
        @orientation = :south
    end
  end

  def turn_right
    case @orientation
      when :north
        @orientation = :east
      when :south
        @orientation = :west
      when :east
        @orientation = :south
      when :west
	      @orientation = :north
    end
  end 

  def position
  	[@x, @y, @orientation]
  end

  def perform_commands(commands)
  	commands.each do |e|
  		if not respond_to?(e)
  			raise InvalidCommandException, "Invalid command in list: #{e}"
  		end
  	end

    moved_through = [position]

  	commands.each do |e|  
  		send e
      moved_through << position
  	end

    moved_through
  end

  private
  def move_distance(increment)
  	desired_x = @x
  	desired_y = @y

		case @orientation
	  	when :north
				desired_y += increment
	  	when :south
				desired_y -= increment
	  	when :east
	  		desired_x += increment
	  	when :west
	  		desired_x -= increment
  	end

  	validate_position(desired_x, desired_y, 'Taxi is not permitted to move outside the grid.') 

  	@x = desired_x
  	@y = desired_y
  end

  def validate_position(x, y, error_message)
  	if not Grid.valid_position?(x, y) 
			raise OutsideGridException, error_message
  	end
  end
end
