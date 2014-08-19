require 'driver'

RSpec.describe Driver do
  it "should honk when pressed" do
    d = Driver.new "-" #arrange
     #act
    expect(d.honk).to eq('honk honk toot toot beep beep') #assert
  end
end
