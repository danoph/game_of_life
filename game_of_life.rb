class GameOfLife
  attr_reader :world, :grid_width, :grid_height

  def initialize(world, cells, grid_height=4, grid_width=4)
    @world = world
    @grid_width = grid_width
    @grid_height = grid_height

    add_cells(cells)
  end

  def add_cells(cells)
    (1..grid_height).each do |y|
      (1..grid_width).each do |x|
        cell = cells.detect{|cell| cell.x == x && cell.y == y } || DeadCell.new(world, x, y)
        world.add_cell(cell)
      end
    end
  end

  def output
    output = ""

    world.cells.each do |key, cell|
      output += cell.to_s
      output += "\n" if cell.x == grid_width
    end

    output
  end

  def run
    while true
      system "clear"
      puts output
      world.tick!
      sleep 0.1
    end
  end
end

class World
  attr_reader :cells

  def initialize
    @cells = {}
  end

  def add_cells(cells)
    cells.each {|cell| add_cell(cell) }
  end

  def add_cell(cell)
    @cells[cell.key] = cell
  end

  def cell(x, y)
    cells["#{x},#{y}"]
  end

  def tick!
    @cells = Hash[cells.map{|key,cell| [ key, cell.tick ] }]
  end
end

class Cell
  attr_reader :world, :x, :y

  def initialize(world, x, y)
    @world = world
    @x = x
    @y = y
    raise "Cannot instantiate directly!" if self.class == Cell
  end

  def key
    "#{x},#{y}"
  end

  def dead?
    !alive?
  end

  def neighbors
    [
      world.cell(x-1, y-1), # northwest
      world.cell(x, y-1), # north
      world.cell(x+1, y-1), # northeast
      world.cell(x+1, y), # east
      world.cell(x+1, y+1), # southeast
      world.cell(x, y+1), # south
      world.cell(x-1, y+1), # southwest
      world.cell(x-1, y) # west
    ].compact
  end

  def live_neighbors
    neighbors.select(&:alive?)
  end
end

class LiveCell < Cell
  def tick
    if live_neighbors.count < 2 || live_neighbors.count > 3
      DeadCell.new(world, x, y)
    elsif [2,3].include? live_neighbors.count
      LiveCell.new(world, x, y)
    else
      self
    end
  end

  def alive?
    true
  end

  def to_s
    "O"
  end
end

class DeadCell < Cell
  def tick
    live_neighbors.count == 3 ? LiveCell.new(world, x, y) : self
  end

  def alive?
    false
  end

  def to_s
    "."
  end
end
