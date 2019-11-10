require_relative './game_of_life'
require 'tty-table'

def render_table(occupied_cells = [], grid_size = 5)
  table_rows = []
  grid_size.times.each do |row|
    table_rows[row] = []
    grid_size.times.each do |col|
      table_rows[row][col] = '.'
    end
  end

  occupied_cells.each do |cell|
    x, y = cell

    table_rows[y][x] = 'O'
  end

  table = TTY::Table.new table_rows
  puts table.render(:unicode)
end

TOTAL_EVOLUTIONS = 5

TOTAL_EVOLUTIONS.times.each do |generation|
  puts "\e[H\e[2J"

  puts "Generation #{generation + 1}"

  # Gets occupied cells & grid size to render
  render_table
  sleep 1

  # Tick to next generation
end
