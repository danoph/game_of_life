require_relative 'game_of_life'

world = World.new

blinker_cells = [
  Cell.new(world, 3, 2),
  Cell.new(world, 3, 3),
  Cell.new(world, 3, 4)
]

block_cells = [
  Cell.new(world, 2, 2),
  Cell.new(world, 3, 2),
  Cell.new(world, 2, 3),
  Cell.new(world, 3, 3)
]

beacon_cells = [
  Cell.new(world, 2, 2),
  Cell.new(world, 3, 2),
  Cell.new(world, 2, 3),
  Cell.new(world, 5, 5),
  Cell.new(world, 4, 5),
  Cell.new(world, 5, 4)
]

game = GameOfLife.new(world, beacon_cells, 6, 6)

game.run
