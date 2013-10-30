class GameOfLife
  attr_reader :world, :grid_width, :grid_height

  def initialize(cells, grid_height=4, grid_width=4)
    @world = World.new(cells)
    @grid_width = grid_width
    @grid_height = grid_height
  end

  def run
    output = ""

    (1..grid_height).each do |y|
      (1..grid_width).each do |x|
        if world.cell_at?(x, y) && world.cells_hash["#{x},#{y}"].alive?
          output += "o"
        else
          output += " "
        end
      end
      output += "\n"
    end
  end
end

class World
  attr_reader :cells, :cells_hash

  def initialize(cells)
    @cells = cells
    @cells_hash = {}

    cells.each do |cell|
      cells_hash[cell.key] = cell
    end
  end

  def cell_at?(x, y)
    cells_hash.has_key?("#{x},#{y}")
  end
end

class Cell
  attr_reader :x, :y, :state, :world

  def initialize(world, x, y)
    @world = world
    @state = :alive
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

  def die!
    @state = :dead
  end

  def revive!
    @state = :alive
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

  def tick!
    if alive?
      if live_neighbors.count < 2 || live_neighbors.count > 3
        die!
      elsif [2,3].include? live_neighbors.count
        revive!
      end
    else
      if live_neighbors.count == 3
        revive!
      end
    end
  end
end
