require_relative 'game_of_life'
require_relative 'pattern_loader'

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

beacon = "http://conwaylife.com/patterns/1beacon.cells"
threeships = "http://conwaylife.com/patterns/3enginecordership.cells"
boats = "http://conwaylife.com/patterns/4boats.cells"
fumaroles = "http://conwaylife.com/patterns/2fumaroles.cells"
bricklayer = "http://conwaylife.com/patterns/bricklayer.cells"

cells_from_internet = PatternLoader.new(bricklayer, world).cells

game = GameOfLife.new(world, cells_from_internet, 39, 178)

game.run
