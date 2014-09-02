require "operator"


describe Operator do
	context 'operator is asked to enter a starting location' do
		# it 'should accept the input from operator and display the inputs' do
		# 	@operator = Operator.new

		# 	expect(@operator.set_location).to eq([0, 0, :north])
		# end

		# it 'should accept list of instructions and move car to final destination case 1' do

		# 	@operator = Operator.new

		# 	@operator.set_location

		# 	expect(@operator.instruction_stack(@car)).to eq([3, 2, :north])
		# end

		it 'should create a location for a new car created' do
			@operator = Operator.new
			# @operator.create_car(0, 0, N)
			expect(@operator.create_car(0, 0, :north)).to eq([0, 0, :north])
		end

		it 'should split the input from console into variables' do
			@operator = Operator.new

			expect(@operator.get_location("0,0,N MLMMRM")).to eq([0, 0, :N])
		end

		it 'should return instructions' do
			@operator = Operator.new 

			expect(@operator.get_instruction("0,0,N MLMMRM")).to eq([:M, :L, :M, :M, :R, :M])
		end

	end
end
