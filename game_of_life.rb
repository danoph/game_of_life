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
  attr_reader :x, :y, :state

  def initialize(x, y)
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
end
