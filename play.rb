require_relative './game_of_life'
require 'tty-table'
require_relative './cell'

def parse_seed(input)
  seed = []
  input.each_index do |row_index|
    col_cells = input[row_index].split('')
    col_cells.each_index do |col_index|
      seed << Cell.new(col_index, row_index) if col_cells[col_index] == 'O'
    end
  end

  seed
end

def render_table(life)
  grid_range = life.grid_range

  table_rows = []
  grid_range[:max_rows].times.each do |row|
    table_rows[row] = []
    grid_range[:max_cols].times.each do |col|
      table_rows[row][col] = '.'
    end
  end

  life.live_cells.each do |cell|
    table_rows[cell.row][cell.col] = 'O'
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
# input = [
#   '.....',
#   '..O..',
#   '...O.',
#   '.OOO.',
#   '.....'
# ]

# Random
# input = [
#   '.....',
#   '.O...',
#   '..OO.',
#   '.OO.O',
#   '..O..'
# ]

input = [
  'O..O.',
  '....O',
  'O...O',
  '.OOOO',
]

seed = parse_seed(input)
life = GameOfLife.new(seed)

50.times.each do |generation|
  puts "\e[H\e[2J"

  puts "Generation #{generation + 1}"
  render_table(life)
  sleep 1

  life.tick
end
