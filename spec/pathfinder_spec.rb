require 'pathfinder'

describe Pathfinder do
	describe 'when generating paths' do
		it 'should generate an empty path when moving from the starting location to the same location' do
			@pathfinder = Pathfinder.new

			path = @pathfinder.generate_path([1, 1, :north], [1, 1])

			expect(path).to eq([])
		end

		it 'should generate a path when moving from the starting location to next point forwards' do
			@pathfinder = Pathfinder.new

			path = @pathfinder.generate_path([1, 1, :north], [1, 2])

			expect(path).to eq([:move_forward])
		end

		it 'should generate the required path when moving from the starting location to the next point to the side' do
			@pathfinder = Pathfinder.new

			path = @pathfinder.generate_path([1, 1, :north], [2, 1])

			expect(path).to eq([:turn_right, :move_forward])
		end

		it 'should generate the required path when moving from the starting location to the next point after 2 turns' do
			@pathfinder = Pathfinder.new

			path = @pathfinder.generate_path([1, 1, :north], [2, 2])

			expect(path).to eq([:turn_right, :move_forward, :turn_left, :move_forward])
		end

		it 'should generate the required path when moving from the starting location to a distant point' do
			@pathfinder = Pathfinder.new

			path = @pathfinder.generate_path([1, 1, :south], [3, 4])

			expect(path).to eq([:turn_left, :move_forward, :move_forward, :turn_left, :move_forward, :move_forward, :move_forward])
		end

		it 'should generate the required path when moving from the starting location to a point to the south-west' do
			@pathfinder = Pathfinder.new

			path = @pathfinder.generate_path([3, 4, :east], [1, 1])

			expect(path).to eq([:turn_right, :turn_right, :move_forward, :move_forward, :turn_left, :move_forward, :move_forward, :move_forward])
		end
	end

	describe 'when turning a taxi to face the desired direction' do
		it 'should return an empty path when turning to the same direction' do
			@pathfinder = Pathfinder.new

			turns = @pathfinder.turn_to_orientation(:north, :north)

			expect(turns).to eq([])
		end

		it 'should turn left if that path is shorter' do 
			@pathfinder = Pathfinder.new

			turns = @pathfinder.turn_to_orientation(:east, :north)

			expect(turns).to eq([:turn_left])
		end

		it 'should turn right if that path is shorter' do 
			@pathfinder = Pathfinder.new

			turns = @pathfinder.turn_to_orientation(:north, :east)

			expect(turns).to eq([:turn_right])
		end

		it 'should generate a reasonable path if turning 180 degrees' do 
			@pathfinder = Pathfinder.new

			turns = @pathfinder.turn_to_orientation(:north, :south)

			expect(turns).to eq([:turn_right, :turn_right])
		end

		it 'should turn from facing west to facing north in one step' do
			@pathfinder = Pathfinder.new

			turns = @pathfinder.turn_to_orientation(:west, :north)

			expect(turns).to eq([:turn_right])
		end

		it 'should turn from facing north to facing west in one step' do
			@pathfinder = Pathfinder.new

			turns = @pathfinder.turn_to_orientation(:north, :west)

			expect(turns).to eq([:turn_left])
		end
	end
end