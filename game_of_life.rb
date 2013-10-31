class GameOfLife
  attr_reader :world, :grid_width, :grid_height

  def initialize(world, cells, grid_height=10, grid_width=10)
    @world = world
    @grid_width = grid_width
    @grid_height = grid_height

    add_cells(cells)
  end

  def add_cells(cells)
    all_cells = []

    (1..grid_height).each do |y|
      (1..grid_width).each do |x|
        unless cell = cells.detect{|cell| cell.x == x && cell.y == y }
          cell = Cell.new(world, x, y, :dead)
        end

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

  def cell_at(x, y)
    cells["#{x},#{y}"]
  end

  def tick!
    @cells = Hash[cells.map{|key,cell| [ key, cell.tick ] }]
  end
end

class Cell
  attr_reader :world, :x, :y, :state

  def initialize(world, x, y, state = :alive)
    @world = world
    @state = state
    @x = x
    @y = y
  end

  def key
    "#{x},#{y}"
  end

  def alive?
    !dead?
  end

  def dead?
    state == :dead
  end

  def neighbors
    [
      world.cell_at(x-1, y-1), # northwest
      world.cell_at(x, y-1), # north
      world.cell_at(x+1, y-1), # northeast
      world.cell_at(x+1, y), # east
      world.cell_at(x+1, y+1), # southeast
      world.cell_at(x, y+1), # south
      world.cell_at(x-1, y+1), # southwest
      world.cell_at(x-1, y) # west
    ].compact
  end

  def live_neighbors
    neighbors.select(&:alive?)
  end

  def tick
    if alive?
      if live_neighbors.count < 2 || live_neighbors.count > 3
        new_cell = Cell.new(world, x, y, :dead)
      elsif [2,3].include? live_neighbors.count
        new_cell = Cell.new(world, x, y, :alive)
      end
    else
      if live_neighbors.count == 3
        new_cell = Cell.new(world, x, y, :alive)
      end
    end

    new_cell ||= self
  end

  def to_s
    alive? ? "O" : "."
  end
end
