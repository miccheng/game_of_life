require 'spec_helper'
require_relative '../game_of_life'

# Any live cell with fewer than two live neighbours dies, as if caused by underpopulation.
# Any live cell with more than three live neighbours dies, as if by overcrowding.
# Any live cell with two or three live neighbours lives on to the next generation.
# Any dead cell with exactly three live neighbours becomes a live cell.

# [ x, y ]
# [ col, row ]

describe 'GameOfLife' do
  context 'death' do
    describe 'underpopulation' do
      it 'dies' do
        seed = [
          [0, 0], [1, 1]
        ]
        gol = GameOfLife.new(seed)
        gol.tick

        expect(gol.cell_state([1, 1])).not_to be
      end
    end

    describe 'overcrowding' do
      it 'dies' do
        seed = [
          [0, 0], [1, 0], [2, 0],
          [0, 1], [1, 1]
        ]
        gol = GameOfLife.new(seed)
        gol.tick

        expect(gol.cell_state([1, 1])).not_to be
      end
    end
  end

  context 'lives' do
    describe 'survive' do
      it 'lives' do
        seed = [
          [0, 1],
          [2, 1],
          [1, 1]
        ]
        gol = GameOfLife.new(seed)
        gol.tick

        expect(gol.cell_state([1, 1])).to be
      end
    end

    describe 'revive' do
      it 'reproduces' do
        seed = [
          [0, 0], [1, 0], [2, 0]
        ]
        gol = GameOfLife.new(seed)
        gol.tick

        expect(gol.cell_state([1, 1])).to be
      end
    end
  end
end
