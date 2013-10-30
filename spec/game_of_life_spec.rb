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

    let(:cells) { [ cell ] }
    let(:cell) { Cell.new(2, 2) }

    it 'says whether cell is at a position' do
      subject.cell_at?(2, 2).should == true
    end
  end
end
