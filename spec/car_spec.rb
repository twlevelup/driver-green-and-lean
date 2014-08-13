require 'car'

RSpec.describe Car do

  context 'when a car starts at (1, 1, N)' do
  	before(:each) do
	  	@d = Car.new(1, 1, :north)
	  end

	  it 'should report its position as (1, 1) and be pointing north' do 
  		expect(@d.position).to eq([1, 1, :north])
  	end

	  context 'and it moves forward' do
	  	before(:each) do
		  	@d.move_forward
		  end

		  it 'should move the car to (1, 2) and still be pointing north' do 
	  		expect(@d.position).to eq([1, 2, :north])
	  	end
	  end
  end

  context 'when a car starts at (1, 1), is pointing south and moves forward' do
  	before(:each) do
	  	@d = Car.new(1, 1, :south)
	  	@d.move_forward
	  end

  	it 'should move the car to (1, 0) and still be pointing south' do 
  		expect(@d.position).to eq([1, 0, :south])
  	end
  end

  context 'when a car starts at (1, 2), is pointing north and moves forward' do 
  	before(:each) do
  		@d = Car.new(1, 2, :north)
  		@d.move_forward
  	end

  	it 'should move the car to (1, 3) and still be pointing north' do
  		expect(@d.position).to eq([1, 3, :north])
  	end
  end

  context 'when a car starts at (1, 2), is pointing south and moves forward' do 
  	before(:each) do
  		@d = Car.new(1, 2, :south)
  		@d.move_forward
  	end

  	it 'should move the car to (1, 1) and still be pointing south' do
  		expect(@d.position).to eq([1, 1, :south])
  	end
  end

  context 'when a car starts at (1, 1), is pointing east and moves forward' do 
  	before(:each) do
  		@d = Car.new(1, 1, :east)
  		@d.move_forward
  	end

  	it 'should move the car to (2, 1) and still be pointing east' do
  		expect(@d.position).to eq([2, 1, :east])
  	end
  end

  context 'when a car starts at (1, 1), is pointing west and moves forward' do 
  	before(:each) do
  		@d = Car.new(1, 1, :west)
  		@d.move_forward
  	end

  	it 'should move the car to (0, 1) and still be pointing west' do
  		expect(@d.position).to eq([0, 1, :west])
  	end
  end

  it 'should not allow invalid starting orientations' do
  	expect { Car.new(1, 1, :rubbish) }.to raise_error('Invalid orientation.')
  end
end







