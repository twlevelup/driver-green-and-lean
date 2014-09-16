require 'operator'

describe Operator do
	describe 'when parsing a starting location and orientation' do
		{ 
			'0,0,N' => [0, 0, :north],
			'0,0,S' => [0, 0, :south],
			'1,2,E' => [1, 2, :east], 
			'1,2,W' => [1, 2, :west],
		}.each do |input, expectedOutput|
			it "should parse '#{input}' as #{expectedOutput}" do
				@operator = Operator.new

				actual = @operator.parse_starting_position(input)

				expect(actual).to eq(expectedOutput)
			end	
		end

		[
			'',
			'0,0,0,N',
			'0,0,X',
			'1.5,2.2,S',
			'a, B, w',
			'-1,0,N'
		].each do |badInput| 
			it "should report '#{badInput}' as invalid" do
				@operator = Operator.new

				expect { @operator.parse_starting_position(badInput) }.to raise_error(InvalidInputException)
			end
		end
	end

	describe 'when parsing instructions for a car' do
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

				expect { @operator.parse_instruction(badInput) }.to raise_error(InvalidInputException)
			end
		end
	end

	describe 'when parsing a command' do
		{
			'1,2,S MLB' => [[1, 2, :south], [:move_forward, :turn_left, :move_backward]],
			'3,5,W  R' => [[3, 5, :west], [:turn_right]],
			' 4,5,N BMMML' => [[4, 5, :north], [:move_backward, :move_forward, :move_forward, :move_forward, :turn_left]]
		}.each do |input, expectedOutput|
			it "should parse '#{input}' as a car starting at (#{expectedOutput[0][0]}, #{expectedOutput[0][1]}), pointing #{expectedOutput[0][2]} and having the list of commands #{expectedOutput[1]}" do
				@operator = Operator.new

				actual = @operator.parse_command(input)

				expect(actual).to eq(expectedOutput)
			end
		end

		[
			'',
			'1,2,S',
			'1,2,S '
		].each do |badInput|
			it "should report '#{badInput}' as invalid" do
				@operator = Operator.new

				expect { @operator.parse_command(badInput) }.to raise_error(InvalidInputException)
			end
		end
	end

	describe 'when running a user command' do 
		{
			'0,0,N MRMMMLM' => '3,2,N',
			'2,3,W RMRMMLM' => '4,5,N',
			'1,3,E MRMR' => '2,2,W'
		}.each do |input, expectedOutput|
			it "should respond to the input '#{input}' with the response '#{expectedOutput}'" do 
				@operator = Operator.new

				actualOutput = @operator.run_input(input)

				expect(actualOutput).to eq(expectedOutput)
			end
		end

		it 'invalid input should result in help information being displayed' do
			@operator = Operator.new

			actualOutput = @operator.run_input('blerg')

			expect(actualOutput).to include("Enter your command in the format")
		end

		it 'attempting to move a taxi outside the grid should show a warning message and not move the taxi' do
			@operator = Operator.new

			actualOutput = @operator.run_input('2,1,S MM')

			expect(actualOutput).to include('The taxi did not move because the commands would have caused it to move outside the boundary of the CBD.')
			expect(actualOutput).to include('2,1,S')
		end
	end

	describe 'when parsing a destination position' do
		it "should parse '1,2' as (1, 2)" do
			@operator = Operator.new

			actualOutput = @operator.parse_destination('1,2')

			expect(actualOutput).to eq([1, 2])
		end

		[
			'-1,0',
			'ab',
			'0.1,3',
			'3,0.5',
			'6,-3',
			'a,b'
		].each do |badInput|
			it "should report '#{badInput}' as invalid" do
				@operator = Operator.new

				expect { @operator.parse_destination(badInput) }.to raise_error(InvalidInputException)
			end
		end
	end
end
