class GameOfLife
  attr_reader :board

  def initialize(board)
    @board = board
  end

  def tick
    new_board = []

    board.each do |cell|
      num_live_cells = nearby_cells(cell).count
      new_board << cell if (2..3).include?(num_live_cells)
    end

    dead_cells.each do |cell|
      num_live_cells = nearby_cells(cell).count
      new_board << cell if num_live_cells == 3
    end

    @board = new_board
  end

  def count_cells
    board.count
  end

  def cell_state(coord)
    board.any? { |cell| cell == coord }
  end

  def max_grid_size
    max_coord = board.each_with_object([0, 0]) do |cell, m|
      x, y = cell
      m[0] = x if x > m[0]
      m[1] = y if y > m[1]
    end

    max_coord.max + 2
  end

  private

  def candidate_cells(coord)
    x, y = coord

    [
      [x - 1, y - 1], [x, y - 1], [x + 1, y - 1],
      [x - 1, y],                 [x + 1, y],
      [x - 1, y + 1], [x, y + 1], [x + 1, y + 1]
    ]
  end

  def nearby_cells(coord)
    candidate_cells(coord).map { |cell| board.select { |c| c == cell }.first }.compact
  end

  def dead_cells
    blank_board(max_grid_size) - board
  end

  def blank_board(size)
    blank_board = []

    size.times.each do |x|
      size.times.each do |y|
        blank_board << [x, y]
      end
    end

    blank_board
  end
end
