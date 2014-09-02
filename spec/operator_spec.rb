require "operator"

describe Operator do
	describe 'parsing starting location' do
		{ 
			'0,0,N' => [0, 0, :north],
			'0,0,S' => [0, 0, :south],
			'1,2,E' => [1, 2, :east], 
			'1,2,W' => [1, 2, :west],
		}.each do |input, expectedOutput|
			it "should parse '#{input}' correctly" do
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
			it "should correctly report '#{badInput}' as invalid" do
				@operator = Operator.new

				actual = @operator.parse_position(badInput)

				expect(actual).to eq(nil)
			end
		end
	end
end
