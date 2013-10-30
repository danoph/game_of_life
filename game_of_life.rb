class GameOfLife
  attr_reader :world, :grid_width, :grid_height

  def initialize(world, cells, grid_height=4, grid_width=4)
    @world = world
    @grid_width = grid_width
    @grid_height = grid_height

    world.add_cells(all_cells(cells))
  end

  def all_cells(cells)
    all_cells = []

    (1..grid_height).each do |y|
      (1..grid_width).each do |x|
        if cell = cells.detect{|cell| cell.x == x && cell.y == y }
          all_cells << cell
        else
          all_cells << Cell.new(world, x, y, :dead)
        end
      end
    end

    all_cells
  end

  def output
    output = ""

    (1..grid_height).each do |y|
      (1..grid_width).each do |x|
        if world.cell_at(x, y).alive?
          output += "O"
        else
          output += " "
        end
      end
      output += "\n"
    end

    output
  end

  def run
    while true
      #system "clear"
      puts output
      world.tick!
      sleep 0.75
    end
  end
end

class World
  attr_reader :cells

  def initialize
    @cells = {}
  end

  def add_cells(cells)
    cells.each do |cell|
      @cells[cell.key] = cell
    end
  end

  def cell_at(x, y)
    cells["#{x},#{y}"]
  end

  def tick!
    new_cells = {}

    cells.each do |key, cell|
      new_cells[key] = cell.tick
    end

    @cells = new_cells
  end
end

class Cell
  attr_reader :x, :y, :state, :world

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
    @state == :dead
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
end
