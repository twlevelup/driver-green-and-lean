require 'car'

describe Car do
  context 'when a car starts at (1, 1) and is pointing north' do
  	it 'should report its position as (1, 1) and be pointing north' do 
	  	@car = Car.new(1, 1, :north)

  		expect(@car.position).to eq([1, 1, :north])
  	end
  end

  { 
  	[1, 1, :north] => {:forward => [1, 2], :backward => [1, 0]},
  	[1, 2, :north] => {:forward => [1, 3], :backward => [1, 1]},
  	[1, 1, :south] => {:forward => [1, 0], :backward => [1, 2]},
  	[1, 2, :south] => {:forward => [1, 1], :backward => [1, 3]},
  	[1, 1, :east] => {:forward => [2, 1], :backward => [0, 1]},
  	[1, 1, :west] => {:forward => [0, 1], :backward => [2, 1]}
  }.each do |start, expectedEnd|
  	describe "when a car starts at (#{start[0]}, #{start[1]}) and is pointing #{start[2]}" do

  		before :each do
  			@car = Car.new(start[0], start[1], start[2])
  		end

	  	it "it should move forward to (#{expectedEnd[:forward][0]}, #{expectedEnd[:forward][1]}), and still be pointing #{start[2]}" do
				@car.move_forward

		  	expect(@car.position).to eq([expectedEnd[:forward][0], expectedEnd[:forward][1], start[2]])
			end

			it "it should move backward to (#{expectedEnd[:backward][0]}, #{expectedEnd[:backward][1]}), and still be pointing #{start[2]}" do
				@car.move_backward

		  	expect(@car.position).to eq([expectedEnd[:backward][0], expectedEnd[:backward][1], start[2]])
			end
		end
  end

  it 'should not allow invalid starting orientations' do
  	expect { Car.new(1, 1, :rubbish) }.to raise_error('Invalid orientation.')
  end

  { 
  	:north => {:left => :west, :right => :east},
  	:east => {:left => :north, :right => :south},
  	:south => {:left => :east, :right => :west},
  	:west => {:left => :south, :right => :north}
  }.each do |initialDirection, expectedDirections| 
  	describe "when a car is pointing #{initialDirection}" do
  		before :each do 
				@car = Car.new(1, 1, initialDirection)
  		end

  		it "after turning left, it should be facing #{expectedDirections[:left]}" do
  			@car.turn_left

  			expect(@car.orientation).to eq(expectedDirections[:left])
  		end

  		it "after turning right, it should be facing #{expectedDirections[:right]}" do
  			@car.turn_right

  			expect(@car.orientation).to eq(expectedDirections[:right])
  		end
  	end
  end

  {
    [0, 0, :north, []] => [0, 0, :north]
  }.each do |input, expectedEnd|
    describe "when a car starts at #{input[0]}, #{input[1]} and is pointing #{input[2]}" do
      it "should move to #{expectedEnd[0]}, #{expectedEnd[1]} after performing the list of commands: #{input[3]}" do
        @car = Car.new(input[0], input[1], input[2])

        @car.perform_commands(input[3])

        expect(@car.position).to eq(expectedEnd)
      end
    end
  end
end
