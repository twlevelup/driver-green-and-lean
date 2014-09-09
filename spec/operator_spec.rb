require "operator"


 describe Operator do
	context 'operator is asked to enter a starting location and instructions' do

		it 'should create a location for a new car created' do
			@operator = Operator.new

			expect(@operator.create_car(0, 0, :north)).to eq([0, 0, :north])
		end
 
		it 'should return instructions' do
			@operator = Operator.new 

			instruct = @operator.get_instruction("0,0,N MLMMRM")

			expect(instruct).to eq([:M, :L, :M, :M, :R, :M])
		end

	{
		'0,0,N MRMMMLM' => [3, 2, :north],
		'2,3,W RMRMMLM' => [4, 5, :north],
	}.each do |input, expectedEnd|

		describe "given car location and instructions #{input}" do 

			before :each do 
				@operator = Operator.new 
				location = @operator.get_position(input)
				@car = @operator.create_car(location[0], location[1], location[2])
			end

			it "it should move car to [#{expectedEnd[0]}, #{expectedEnd[1]}] and pointing #{expectedEnd[2]}" do

				@instructions = @operator.get_instruction(input)
				move = @operator.move_car(@car, @instructions)
				
				expect(move).to eq(expectedEnd)
			end	
		end

	end
end


describe 'separating starting location from input' do
 	{
 		'0,0,N MLMMRM' => [0, 0, :north],
 		'2,3,W MLBBRM' => [2, 3, :west],
 		'1,3,E MLMMRM' => [1, 3, :east],
 		'4,1,S MLMMRM' => [4, 1, :south],
 		'4,3,N MLMMRM' => [4, 3, :north],
 	}.each do |input, expectedOutput|
		it "should parse location from #{input} and return #{expectedOutput}" do
			@operator = Operator.new

			location = @operator.get_position(input)

			expect(location).to eq(expectedOutput)
		end

  end
end

describe 'identifying non-numeric input in location' do
 	{
 		'0,O,N MLMMRM' => nil,
 		'!@,#$,W MLBBRM' => nil,
 		'..k,,3,E MLMMRM' => nil,
 		'..6k,#$$%,S MLMMRM' => nil,

 	}.each do |input, expectedOutput|
		it "should parse location from #{input} and return nil" do
			@operator = Operator.new

			location = @operator.get_position(input)

			expect(location).to eq(expectedOutput)
		end

  end
end

describe 'separating instructions from input' do
 	{
 		'0,0,N,M LMBRBM' => nil,
 		'0,0,N MLMMRM' => [:M, :L, :M, :M, :R, :M],
 		'2,3,W MLBBRM' => [:M, :L, :B, :B, :R, :M],
 		'1,3,E MLMMRM' => [:M, :L, :M, :M, :R, :M],
 		'4,1,S MRMBMRMB' => [:M, :R, :M, :B, :M, :R, :M, :B],
 	}.each do |input, expectedOutput|
		it "should parse instructions stack from #{input} and return #{expectedOutput}" do
			@operator = Operator.new

			instructions = @operator.get_instruction(input)

			expect(instructions).to eq(expectedOutput)
		end

 	end
end

end

