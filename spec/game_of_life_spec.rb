require 'spec_helper'
require_relative '../game_of_life'
require_relative '../cell'

# Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
# Any live cell with more than three live neighbours dies, as if by overcrowding.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any dead cell with exactly three live neighbours becomes a live cell.

describe 'GameOfLife' do
  describe '.initialize' do
    it 'creates live cells' do
      seed = [
        Cell.new(1, 1)
      ]
      life = GameOfLife.new(seed)

      expect(life.live_cells).to eq seed
    end
  end

  describe 'stable population' do
    it 'stays alive' do
      seed = [
        Cell.new(1, 1),
        Cell.new(2, 1),
        Cell.new(2, 2)
      ]
      life = GameOfLife.new(seed)
      life.tick

      expect(life.cell_at(2, 2)).to eq Cell::ALIVE
    end
  end

  describe 'overpopulation' do
    it 'cell dies' do
      seed = [
        Cell.new(1, 1),
        Cell.new(2, 1),
        Cell.new(3, 1),
        Cell.new(3, 2),
        Cell.new(2, 2)
      ]
      life = GameOfLife.new(seed)
      life.tick

      expect(life.cell_at(2, 2)).to eq Cell::DEAD
    end
  end

  describe 'underpopulation' do
    it 'cell dies' do
      seed = [
        Cell.new(1, 1),
        Cell.new(2, 2)
      ]
      life = GameOfLife.new(seed)
      life.tick

      expect(life.cell_at(2, 2)).to eq Cell::DEAD
    end
  end

  describe 'reproduction' do
    it 'cell revives' do

      seed = [
        Cell.new(1, 1),
        Cell.new(2, 1),
        Cell.new(3, 1)
      ]
      life = GameOfLife.new(seed)
      life.tick

      expect(life.cell_at(2, 2)).to eq Cell::ALIVE
    end
  end
end
