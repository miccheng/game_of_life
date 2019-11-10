require 'spec_helper'
require_relative '../cell'

# Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
# Any live cell with more than three live neighbours dies, as if by overcrowding.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any dead cell with exactly three live neighbours becomes a live cell.

describe 'Cell' do
  describe '.initialize' do
    it 'has x and y' do
      col = 1
      row = 1

      cell = Cell.new(col, row)

      expect(cell.col).to eq col
      expect(cell.row).to eq row
    end
  end

  describe 'cell operations in array' do
    it 'comparator' do
      expect(Cell.new(1, 1) == Cell.new(1, 1)).to be
      expect(Cell.new(1, 2) == Cell.new(1, 1)).not_to be
    end

    it 'removes from an array' do
      col = 1
      row = 1
      list = [
        Cell.new(col, row),
        Cell.new(2, 2),
        Cell.new(3, 3)
      ]

      list.delete(Cell.new(col, row))

      expect(list.count).to eq 2

      removed_cell = list.select { |cell| cell.col == col && cell.row == row }
      expect(removed_cell).to be_empty
    end
  end

  describe '#neighbours_of' do
    it 'shows neighbour coords' do
      cell = Cell.new(1, 1)
      neighbours = Cell.neighbours_of(cell)

      expect(neighbours.count).to eq 8
      expect(neighbours).to eq [[0, 0], [1, 0], [2, 0], [0, 1], [2, 1], [0, 2], [1, 2], [2, 2]]
    end
  end

  describe '#transpose!' do
    it 'moves cell 1 col right and 1 row down' do
      cell = Cell.new(2, 2)

      cell.transpose!

      expect(cell.col).to eq 3
      expect(cell.row).to eq 3
    end
  end

  it 'dies from underpopulation' do
    next_state = Cell.next_state(current_state: Cell::ALIVE, neighbours: 1)
    expect(next_state).to eq Cell::DEAD
  end

  it 'dies from overpopulation' do
    next_state = Cell.next_state(current_state: Cell::ALIVE, neighbours: 4)
    expect(next_state).to eq Cell::DEAD
  end

  it 'continues to live from stable population' do
    next_state = Cell.next_state(current_state: Cell::ALIVE, neighbours: 2)
    expect(next_state).to eq Cell::ALIVE
  end

  it 'reproduces when sufficient population' do
    next_state = Cell.next_state(current_state: Cell::DEAD, neighbours: 3)
    expect(next_state).to eq Cell::ALIVE
  end
end
