require 'car'

RSpec.describe Car do
  context 'when a car starts at (1, 1) and is pointing north' do
  	it 'should report its position as (1, 1) and be pointing north' do 
	  	@d = Car.new(1, 1, :north)

  		expect(@d.position).to eq([1, 1, :north])
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
				@d = Car.new(start[0], start[1], start[2])

		  	@d.move_forward

		  	expect(@d.position).to eq([expectedEnd[0], expectedEnd[1], start[2]])
			end
		end
  end

  it 'should not allow invalid starting orientations' do
  	expect { Car.new(1, 1, :rubbish) }.to raise_error('Invalid orientation.')
  end

    context 'when a car starts at (1, 1), is pointing north and turns left' do 
    before(:each) do
      @d = Car.new(1, 1, :north)
      @d.turn_left
    end

    it 'should move the car to (1, 1) and be pointing west' do
      expect(@d.position).to eq([1, 1, :west])
    end
  end

end
