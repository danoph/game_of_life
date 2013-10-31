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

spaceship_cells = [
  Cell.new(world, 3, 4),
  Cell.new(world, 4, 4),
  Cell.new(world, 5, 4),
  Cell.new(world, 5, 3),
  Cell.new(world, 4, 2),
]

game = GameOfLife.new(world, spaceship_cells, 40, 100)

game.run
