require_relative './game_of_life'
require 'tty-table'

def parse_seed(input)
  seed = []
  input.each_index do |row_index|
    col_cells = input[row_index].split('')
    col_cells.each_index do |col_index|
      seed << [col_index, row_index] if col_cells[col_index] == 'O'
    end
  end

  seed
end

def render_table(life)
  grid_size = life.max_grid_size

  table_rows = []
  grid_size.times.each do |row|
    table_rows[row] = []
    grid_size.times.each do |col|
      table_rows[row][col] = '.'
    end
  end

  life.board.each do |cell|
    x, y = cell

    table_rows[y][x] = 'O'
  end

  table = TTY::Table.new table_rows
  puts table.render(:unicode)
end

# [ x, y ]
# [ col, row ]

# Still life
# Block
# seed = [
#   [1, 1], [2, 1], [1, 2], [2, 2]
# ]
# input = [
#   '.....',
#   '.OO..',
#   '.OO..'
# ]

# Tub
# seed = [
#   [2, 1], [1, 2], [3, 2], [2, 3]
# ]
# input = [
#   '.....',
#   '..O..',
#   '.O.O.',
#   '..O..'
# ]

# Oscillators
# Blinker
# seed = [
#   [2, 1], [2, 2], [2, 3]
# ]
# input = [
#   '.....',
#   '..O..',
#   '..O..',
#   '..O..',
#   '.....'
# ]

# Spaceships
# Glider
# seed = [
#   [2, 1], [3, 2], [1, 3], [2, 3], [3, 3]
# ]

input = [
  '.....',
  '.O...',
  '..OO.',
  '.OO.O',
  '..O..'
]

seed = parse_seed(input)
life = GameOfLife.new(seed)

20.times.each do |generation|
  puts "\e[H\e[2J"

  puts "Generation #{generation + 1}"
  render_table(life)
  sleep 1

  life.tick
end
