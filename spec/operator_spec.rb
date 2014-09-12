require "operator"

describe Operator do
	describe 'parsing starting location' do
		{ 
			'0,0,N' => [0, 0, :north],
			'0,0,S' => [0, 0, :south],
			'1,2,E' => [1, 2, :east], 
			'1,2,W' => [1, 2, :west],
		}.each do |input, expectedOutput|
			it "should parse '#{input}' as #{expectedOutput}" do
				@operator = Operator.new

				actual = @operator.parse_position(input)

				expect(actual).to eq(expectedOutput)
			end	
		end

		[
			'',
			'0,0,0,N',
			'0,0,X',
			'1.5,2.2,S',
			'a, B, w'
		].each do |badInput| 
			it "should report '#{badInput}' as invalid" do
				@operator = Operator.new

				actual = @operator.parse_position(badInput)

				expect(actual).to eq(nil)
			end
		end
	end

	describe 'parsing instructions for car' do
		{ 
			'' => [],
			'M' => [:move_forward],
			'L' => [:turn_left], 
			'B' => [:move_backward],
			'R' => [:turn_right],
			'MM' => [:move_forward, :move_forward],
			'MR' => [:move_forward, :turn_right],
			'm' => [:move_forward]
		}.each do |input, expectedOutput|
			it "should parse '#{input}' as #{expectedOutput}" do
				@operator = Operator.new

				actual = @operator.parse_instruction(input)

				expect(actual).to eq(expectedOutput)
			end	
		end

		[
			'x',
			'M,M'
		].each do |badInput| 
			it "should report '#{badInput}' as invalid" do
				@operator = Operator.new

				actual = @operator.parse_instruction(badInput)

				expect(actual).to eq(nil)
			end
		end
	end
end
