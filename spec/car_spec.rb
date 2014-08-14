require 'car'

RSpec.describe Car do
  context 'when a car starts at (1, 1) and is pointing north' do
  	it 'should report its position as (1, 1) and be pointing north' do 
	  	@car = Car.new(1, 1, :north)

  		expect(@car.position).to eq([1, 1, :north])
  	end
  end

  { 
  	[1, 1, :north] => [1, 2],
  	[1, 2, :north] => [1, 3],
  	[1, 1, :south] => [1, 0],
  	[1, 2, :south] => [1, 1],
  	[1, 1, :east] => [2, 1],
  	[1, 1, :west] => [0, 1]
  }.each do |start, expectedEnd|
  	describe "when a car starts at (#{start[0]}, #{start[1]}) and is pointing #{start[2]}" do
	  	it "it should move forward to (#{expectedEnd[0]}, #{expectedEnd[1]}), and still be pointing #{start[2]}" do
				@car = Car.new(start[0], start[1], start[2])

		  	@car.move_forward

		  	expect(@car.position).to eq([expectedEnd[0], expectedEnd[1], start[2]])
			end
		end
  end

  it 'should not allow invalid starting orientations' do
  	expect { Car.new(1, 1, :rubbish) }.to raise_error('Invalid orientation.')
  end

  { 
  	:north => :west,
  	:east => :north,
  	:south => :east,
  	:west => :south
  }.each do |initialDirection, expectedDirection| 
  	describe "when a car is pointing #{initialDirection}" do
  		it "after turning left, it should be facing #{expectedDirection}" do
  			@car = Car.new(1, 1, initialDirection)

  			@car.turn_left

  			expect(@car.orientation).to eq(expectedDirection)
  		end
  	end
  end

  { 
  	:north => :east,
  	:east => :south,
  	:south => :west,
  	:west => :north
  }.each do |initialDirection, expectedDirection| 
  	describe "when a car is pointing #{initialDirection}" do
  		it "after turning right, it should be facing #{expectedDirection}" do
  			@car = Car.new(1, 1, initialDirection)

  			@car.turn_right

  			expect(@car.orientation).to eq(expectedDirection)
  		end
  	end
  end

end
