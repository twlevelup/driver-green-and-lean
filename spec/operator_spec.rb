require "operator"

describe Operator do
	context 'operator is asked to enter a starting location' do
		it 'should accept the input from operator and display the inputs' do
			@operator = Operator.new

			expect(@operator.set_location).to eq([0, 0, :north])
		end

		it 'should accept list of instructions and move car to final destination case 1' do

			@operator = Operator.new

			@operator.set_location

			expect(@operator.instruction_stack(@car)).to eq([3, 2, :north])
		end

	end
end
