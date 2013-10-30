#Any live cell with fewer than two live neighbours dies, as if caused by under-population.
#Any live cell with two or three live neighbours lives on to the next generation.
#Any live cell with more than three live neighbours dies, as if by overcrowding.
#Any dead cell with exactly three live neighbours becomes a live cell, as if by reproduction.

require_relative '../game_of_life'

describe GameOfLife do
  let(:world) { World.new }
  let(:dead_cell) { double 'dead cell', alive?: false }

  subject { GameOfLife.new(world, cells) }

  context 'box pattern' do
    let(:cells) { [ cell1, cell2, cell3, cell4 ] }
    let(:cell1) { Cell.new(world, 2, 2) }
    let(:cell2) { Cell.new(world, 3, 2) }
    let(:cell3) { Cell.new(world, 2, 3) }
    let(:cell4) { Cell.new(world, 3, 3) }

    let(:block_pattern) { "    \n OO \n OO \n    \n" }

    it 'displays block pattern' do
      subject.output.should == block_pattern
    end
  end

  describe 'beacon pattern' do
    let(:cell1) { Cell.new(world, 2, 2) }
    let(:cell2) { Cell.new(world, 3, 2) }
    let(:cell3) { Cell.new(world, 2, 3) }
    let(:cell4) { Cell.new(world, 5, 5) }
    let(:cell5) { Cell.new(world, 4, 5) }
    let(:cell6) { Cell.new(world, 5, 4) }
    let(:cells) { [ cell1, cell2, cell3, cell4, cell5, cell6 ] }

    let(:beacon_pattern) { "    \n OO \n O  \n    \n" }

    it 'displays beacon pattern' do
      world.tick!
      subject.output.should == beacon_pattern
    end
  end
end

describe World do
  let(:world) { double 'world', cell_at: nil }

  describe "#cell_at" do
    before { subject.add_cells(cells) }

    let(:cells) { [ cell, cell2 ] }
    let(:cell) { Cell.new(world, 2, 2) }
    let(:cell2) { Cell.new(world, 4, 2) }

    it 'says whether cell is at a position' do
      subject.cell_at(2, 2).should == cell
      subject.cell_at(4, 2).should == cell2
    end
  end

  describe "#tick!" do
    before { subject.add_cells(cells) }

    let(:cells) { [ cell, cell2 ] }
    let(:cell) { Cell.new(world, 2, 2) }
    let(:cell2) { Cell.new(world, 4, 2) }

    it 'ticks world' do
      cells.each do |cell|
        cell.should_receive(:tick)
      end

      subject.tick!
    end
  end
end

describe Cell do
  let(:world) { double 'world', cell_at: nil }

  subject { described_class.new(world, 2, 2) }

  describe "#alive?" do
    it 'should be alive' do
      subject.alive?.should == true
    end
  end

  describe "#dead?" do
    it 'should be dead' do
      subject.dead?.should == false
    end
  end

  describe '#neighbors' do
    describe '#northwest neighbor' do
      before { world.stub(:cell_at).with(subject.x-1, subject.y-1) { cell } }

      let(:cell) { Cell.new(world, 1, 1) }

      it 'knows north neighbor' do
        subject.neighbors.should include(cell)
      end
    end

    describe '#north neighbor' do
      before { world.stub(:cell_at).with(subject.x, subject.y-1) { cell } }

      let(:cell) { Cell.new(world, 2, 1) }

      it 'knows north neighbor' do
        subject.neighbors.should include(cell)
      end
    end

    describe '#norheast neighbor' do
      before { world.stub(:cell_at).with(subject.x+1, subject.y-1) { cell } }

      let(:cell) { Cell.new(world, 3, 1) }

      it 'knows north neighbor' do
        subject.neighbors.should include(cell)
      end
    end

    describe '#east neighbor' do
      before { world.stub(:cell_at).with(subject.x+1, subject.y) { cell } }

      let(:cell) { Cell.new(world, 3, 2) }

      it 'knows north neighbor' do
        subject.neighbors.should include(cell)
      end
    end

    describe '#southeast neighbor' do
      before { world.stub(:cell_at).with(subject.x+1, subject.y+1) { cell } }

      let(:cell) { Cell.new(world, 3, 3) }

      it 'knows north neighbor' do
        subject.neighbors.should include(cell)
      end
    end

    describe '#south neighbor' do
      before { world.stub(:cell_at).with(subject.x, subject.y+1) { cell } }

      let(:cell) { Cell.new(world, 2, 3) }

      it 'knows north neighbor' do
        subject.neighbors.should include(cell)
      end
    end

    describe '#southwest neighbor' do
      before { world.stub(:cell_at).with(subject.x-1, subject.y+1) { cell } }

      let(:cell) { Cell.new(world, 1, 3) }

      it 'knows north neighbor' do
        subject.neighbors.should include(cell)
      end
    end

    describe '#west neighbor' do
      before { world.stub(:cell_at).with(subject.x-1, subject.y) { cell } }

      let(:cell) { Cell.new(world, 1, 2) }

      it 'knows north neighbor' do
        subject.neighbors.should include(cell)
      end
    end
  end

  describe "#tick" do
    context 'when live cell' do
      context 'and fewer than two neighbors' do
        it 'dies' do
          subject.should be_alive
          subject.tick.should be_dead
        end
      end

      context 'when two or three neighbors' do
        let(:cell1) { Cell.new(world, 2, 3) }
        let(:cell2) { Cell.new(world, 1, 1) }

        before do
          world.stub(:cell_at).with(subject.x, subject.y+1) { cell1 }
          world.stub(:cell_at).with(subject.x-1, subject.y-1) { cell2 }
        end

        it 'stays alive' do
          subject.should be_alive
          subject.tick.should be_alive
        end
      end

      context 'when four neighbors' do
        let(:cell1) { Cell.new(world, 1, 1) }
        let(:cell2) { Cell.new(world, 2, 1) }
        let(:cell3) { Cell.new(world, 3, 1) }
        let(:cell4) { Cell.new(world, 1, 2) }

        before do
          world.stub(:cell_at).with(subject.x-1, subject.y-1) { cell1 }
          world.stub(:cell_at).with(subject.x, subject.y-1) { cell2 }
          world.stub(:cell_at).with(subject.x+1, subject.y-1) { cell3 }
          world.stub(:cell_at).with(subject.x-1, subject.y) { cell4 }
        end

        it 'stays alive' do
          subject.should be_alive
          subject.tick.should be_dead
        end
      end
    end

    context 'when dead cell' do
      subject { described_class.new(world, 2, 2, :dead) }

      context 'when three live neighbors' do
        let(:cell1) { Cell.new(world, 1, 1) }
        let(:cell2) { Cell.new(world, 2, 1) }
        let(:cell3) { Cell.new(world, 3, 1) }

        before do
          world.stub(:cell_at).with(subject.x-1, subject.y-1) { cell1 }
          world.stub(:cell_at).with(subject.x, subject.y-1) { cell2 }
          world.stub(:cell_at).with(subject.x+1, subject.y-1) { cell3 }
        end

        it 'should become alive' do
          subject.should be_dead
          subject.tick.should be_alive
        end
      end
    end
  end
end
