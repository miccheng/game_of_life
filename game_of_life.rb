require_relative './cell'

class GameOfLife
  attr_reader :live_cells

  def initialize(seed)
    @live_cells = seed
  end

  def tick
    new_generation = live_cells.map do |cell|
      num_neighbours = count_living_neighbours(cell)
      new_state = Cell.next_state(current_state: Cell::ALIVE,
                                  neighbours: num_neighbours)

      cell if new_state == Cell::ALIVE
    end.compact

    @live_cells = new_generation
  end

  def cell_at(col, row)
    cell = live_cells.select { |c| c.col == col && c.row == row }.first
    cell.nil? ? Cell::DEAD : Cell::ALIVE
  end

  private

  def count_living_neighbours(cell)
    num_living = 0

    Cell.neighbours_of(cell).each do |coord|
      num_living += 1 if cell_at(*coord) == Cell::ALIVE
    end

    num_living
  end

  def grid_range
    live_cells.map(&:col).min
    live_cells.map(&:col).max
    live_cells.map(&:row).max
    live_cells.map(&:row).min
  end
end
