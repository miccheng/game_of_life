require_relative './cell'
require 'set'

class GameOfLife
  attr_reader :live_cells

  def initialize(seed)
    @live_cells = seed
  end

  def tick
    transpose_living_cells! if grid_range[:min] < 1

    new_generation = []
    interesting_cells = Set.new

    live_cells.each do |cell|
      interesting_cells << [cell.col, cell.row]
      interesting_cells.merge(Cell.neighbours_of(cell))
    end

    interesting_cells.each do |coord|
      cell = Cell.new(*coord)
      living_neighbours = count_living_neighbours(cell)
      new_state = Cell.next_state(current_state: cell_at(*coord),
                                  neighbours: living_neighbours)

      new_generation << cell if new_state == Cell::ALIVE
    end

    @live_cells = new_generation
  end

  def cell_at(col, row)
    cell = live_cells.select { |c| c.col == col && c.row == row }.first
    cell.nil? ? Cell::DEAD : Cell::ALIVE
  end

  def grid_range
    {
      min: [live_cells.map(&:col).min, live_cells.map(&:row).min].min,
      max: [live_cells.map(&:col).max, live_cells.map(&:row).max].max,
      max_rows: live_cells.map(&:row).max + 2,
      max_cols: live_cells.map(&:col).max + 2
    }
  end

  private

  def count_living_neighbours(cell)
    num_living = 0

    Cell.neighbours_of(cell).each do |coord|
      num_living += 1 if cell_at(*coord) == Cell::ALIVE
    end

    num_living
  end

  def transpose_living_cells!
    @live_cells = live_cells.map do |cell|
      cell.transpose!
      cell
    end
  end
end
