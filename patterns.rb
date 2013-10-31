require_relative 'game_of_life'

world = World.new

blinker_cells = [
  LiveCell.new(world, 3, 2),
  LiveCell.new(world, 3, 3),
  LiveCell.new(world, 3, 4)
]

block_cells = [
  LiveCell.new(world, 2, 2),
  LiveCell.new(world, 3, 2),
  LiveCell.new(world, 2, 3),
  LiveCell.new(world, 3, 3)
]

beacon_cells = [
  LiveCell.new(world, 2, 2),
  LiveCell.new(world, 3, 2),
  LiveCell.new(world, 2, 3),
  LiveCell.new(world, 5, 5),
  LiveCell.new(world, 4, 5),
  LiveCell.new(world, 5, 4)
]

spaceship_cells = [
  LiveCell.new(world, 3, 4),
  LiveCell.new(world, 4, 4),
  LiveCell.new(world, 5, 4),
  LiveCell.new(world, 5, 3),
  LiveCell.new(world, 4, 2),
]

game = GameOfLife.new(world, spaceship_cells, 40, 100)

game.run
