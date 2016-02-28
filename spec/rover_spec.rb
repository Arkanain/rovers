require './lib/rover'
require 'stringio'

describe Rover, '.set_mission' do
  let(:new_line) { "\n" }
  let(:plato_size) { '5 5' }
  let(:first_rover) { { coords: '1 2 N', trip: 'LMLMLMLMM' } }
  let(:second_rover) { { coords: '3 3 E', trip: 'MMRMMRMRRM' } }
  let(:first_rover_result) { '1 3 N' }
  let(:second_rover_result) { '5 1 E' }

  it 'return nothing but set plato size' do
    $stdin = StringIO.new(plato_size + new_line + new_line)

    rover = Rover.set_mission

    expect(rover.length).to eq(0)
    expect(Rover.grid_size).to eq([5, 5])
  end

  it 'return position for one rover' do
    $stdin = StringIO.new([
                            plato_size,
                            first_rover[:coords],
                            first_rover[:trip]
                          ].join(new_line) + new_line)

    rover = Rover.set_mission

    expect(rover.length).to eq(1)
    expect(rover.first).to eq(first_rover_result)
  end

  it 'return position for two rovers' do
    $stdin = StringIO.new([
                            plato_size,
                            first_rover[:coords],
                            first_rover[:trip],
                            second_rover[:coords],
                            second_rover[:trip]
                          ].join(new_line) + new_line)

    rover = Rover.set_mission

    expect(rover.length).to eq(2)
    expect(rover.first).to eq(first_rover_result)
    expect(rover.last).to eq(second_rover_result)
  end

  it 'should return only results of first rover' do
    $stdin = StringIO.new([
                            plato_size,
                            first_rover[:coords],
                            first_rover[:trip],
                            second_rover[:coords]
                          ].join(new_line) + new_line)

    rover = Rover.set_mission

    expect(rover.length).to eq(1)
    expect(rover.first).to eq(first_rover_result)
  end
end