require 'open-uri'
require 'nokogiri'

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
bunnies = "http://conwaylife.com/patterns/bunnies11.cells"

def hrefs
  patterns_page = "http://conwaylife.com/patterns"
  doc = Nokogiri::HTML(open(patterns_page))
  links = doc.css('a')
  hrefs = links.map {|link| link.attribute('href').to_s}.uniq.sort.delete_if {|href| href.empty?}.select{|href| href.match /\.cell/ }
end

def build_url(href)
  "http://conwaylife.com/patterns/#{href}"
end

random_link = build_url(hrefs.sample)

cells_from_internet = PatternLoader.new(random_link, world).cells

game = GameOfLife.new(world, cells_from_internet, 39, 178)

game.run
