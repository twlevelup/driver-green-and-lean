require 'grid'

RSpec.describe Grid do
	describe 'when checking positions' do
	  [
	  	[-1, 0],
	  	[0, -1],
	  	[0, 6],
	  	[9, 0]
	  ].each do |position|
	  	it "(#{position[0]}, #{position[1]}) should be reported as an invalid position" do
		  	expect(Grid.valid_position?(position[0], position[1])).to be false
		  end
	  end

	  [
	  	[0, 0],
	  	[0, 5],
	  	[8, 5],
	  	[8, 0]
	  ].each do |position|
	  	it "(#{position[0]}, #{position[1]}) should be reported as a valid position" do
		  	expect(Grid.valid_position?(position[0], position[1])).to be true
		  end
	  end
	end
end