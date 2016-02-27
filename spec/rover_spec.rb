require './lib/rover'

describe Rover, '.set_mission' do
  before do
    stub(:gets).and_return "5 5\n"
  end

  it 'return test data' do
    rover = Rover.set_mission

    expect(rover.length).to eq(2)
    expect(rover).to eq([5, 5])
  end
end