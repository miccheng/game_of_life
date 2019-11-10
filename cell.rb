class Cell
  include Comparable

  ALIVE = 1
  DEAD = 0

  attr_reader :col, :row

  def initialize(col, row)
    @col = col
    @row = row
  end

  def self.next_state(current_state:, neighbours:)
    new_state = current_state
    if current_state == ALIVE
      new_state = DEAD unless (2..3).include?(neighbours)
    elsif current_state == DEAD
      new_state = ALIVE if neighbours == 3
    end

    new_state
  end

  def self.neighbours_of(cell)
    [
      [cell.col - 1, cell.row - 1], [cell.col, cell.row - 1],
      [cell.col + 1, cell.row - 1], [cell.col - 1, cell.row],
      [cell.col + 1, cell.row], [cell.col - 1, cell.row + 1],
      [cell.col, cell.row + 1], [cell.col + 1, cell.row + 1]
    ]
  end

  def transpose!
    @col += 1
    @row += 1
  end

  def <=>(other)
    return 0 if other.col == col && other.row == row
  end
end
