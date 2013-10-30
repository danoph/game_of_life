#Any live cell with fewer than two live neighbours dies, as if caused by under-population.
#Any live cell with two or three live neighbours lives on to the next generation.
#Any live cell with more than three live neighbours dies, as if by overcrowding.
#Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

require_relative '../game_of_life'

describe GameOfLife do
  subject { GameOfLife.new(cells) }

  let(:cells) { [ cell1, cell2, cell3, cell4 ] }
  let(:cell1) { Cell.new(2, 2) }
  let(:cell2) { Cell.new(3, 2) }
  let(:cell3) { Cell.new(2, 3) }
  let(:cell4) { Cell.new(3, 3) }

  let(:still_life) { "    \n oo \n oo \n    " }

  it 'should run' do
    subject.run.should == still_life
  end
end

describe World do
  describe "#cell_at?" do
    subject { described_class.new(cells) }

    let(:cells) { [ cell, cell2 ] }
    let(:cell) { Cell.new(2, 2) }
    let(:cell2) { Cell.new(4, 2) }

    it 'says whether cell is at a position' do
      subject.cell_at?(2, 2).should == true
      subject.cell_at?(4, 2).should == true
      subject.cell_at?(3, 2).should == false
    end
  end
end
