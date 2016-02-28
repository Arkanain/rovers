require 'pry'
require 'active_support/core_ext/object/blank.rb'

class Rover
  SIDES = %w{N E S W}

  class << self
    attr_accessor :grid_size

    def set_mission
      results = []
      lines = []

      puts "If you don't want add any more rovers leave line blank and click Enter"
      $stdin.each do |line|
        break if line.chomp.blank?

        lines << line.chomp
      end

      self.grid_size = lines.shift.split(' ').map(&:to_i)

      lines.each_slice(2) do |coords, trip|
        break if coords.blank? || trip.blank?

        results << Rover.new.trip_result(coords.split(' '), trip)
      end

      results
    end
  end

  attr_accessor :x_grid, :y_grid, :head_side

  def trip_result(coords, trip)
    self.x_grid = coords[0].to_i
    self.y_grid = coords[1].to_i
    self.head_side = SIDES.index(coords[2].upcase)

    trip.each_char do |char|
      case char
        when 'L'
          self.head_side -= 1
        when 'R'
          self.head_side += 1
        when 'M'
          go_ahead
      end
    end

    [x_grid, y_grid, SIDES[head_side % 4]].join(' ')
  end

  private

  def go_ahead
    case (head_side % 4)
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