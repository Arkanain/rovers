require 'pry'

class Rover
  SIDES = {
    :N => 0,
    :E => 1,
    :S => 2,
    :W => 3
  }

  class << self
    attr_accessor :grid_size, :results

    def set_mission
      results = []

      puts 'Set grid size:'
      grid = gets.chomp

      self.grid_size = grid.split(' ').map(&:to_i)

      puts "If you don't want add any more rovers leave line blank and click Enter two times"
      loop do
        coords = gets.chomp.split(' ')
        trip = gets.chomp

        break if (coords.empty? or trip.empty?)

        binding.pry
        results << Rover.new.trip_result(coords, trip)
      end

      results.each { |r| puts r }
    end
  end

  attr_accessor :x_grid, :y_grid, :head_side

  def trip_result(coords, trip)
    self.x_grid = coords[0].to_i
    self.y_grid = coords[1].to_i
    self.head_side = SIDES[coords[2].to_sym]

    trip.each_char do |char|
      case char
        when 'L'
          self.head_side = 4 if self.head_side == 0

          self.head_side -= 1
        when 'R'
          self.head_side = 0 if self.head_side == 4

          self.head_side += 1
        when 'M'
          go_ahead
      end
    end

    [x_grid, y_grid, SIDES.key(head_side)].join(' ')
  end

  def go_ahead
    case self.head_side
      when 0
        self.y_grid += 1
      when 1
        self.x_grid += 1
      when 2
        self.y_grid -= 1
      when 3
        self.x_grid -= 1
    end
  end
end