require 'open-uri'

class PatternLoader
  attr_reader :url, :world, :description, :description_url

  def initialize(url)
    @url = url
    @world = World.new
  end

  def name
    @name ||= comments.detect{|comment| comment.match /Name:/ }.scan(/Name:\s*(.*)/i)[0][0]
  end

  def comments
    @comments ||= contents.scan(/^!(.*)$/).map(&:first).map(&:strip)
  end

  def cells
    return @cells if @cells

    @cells = []

    cell_lines.each_with_index do |line, y|
      line.chars.each_with_index do |char, x|
        if char == "O"
          @cells << LiveCell.new(world, x+1, y+1)
        elsif char == "."
          @cells << DeadCell.new(world, x+1, y+1)
        end
      end
    end

    @cells
  end

  def cell_lines
    @cell_lines ||= contents.scan(/^([^!].*)$/).map(&:first)
  end

  def contents
    @contents ||= open(url) {|f| f.read }
  end
end
