require_relative '../pattern_loader'

#!Name: 1 beacon
#!Approximately the 32nd-most common oscillator.
#!www.conwaylife.com/wiki/index.php?title=1_beacon
#..OO
#.O.O
#O..O.OO
#OO.O..O
#.O.O
#.O..O
#..OO

def find_cell(cells, x, y)
  cells.detect{|cell| cell.x == x && cell.y == y }
end

describe PatternLoader do
  let(:beacon) { "http://conwaylife.com/patterns/1beacon.cells" }

  subject { described_class.new(beacon) }

  it 'parses contents correctly' do
    subject.contents.should == "!Name: 1 beacon\r\n!Approximately the 32nd-most common oscillator.\r\n!www.conwaylife.com/wiki/index.php?title=1_beacon\r\n..OO\r\n.O.O\r\nO..O.OO\r\nOO.O..O\r\n.O.O\r\n.O..O\r\n..OO\r\n"
  end

  it 'parses comments correctly' do
    subject.comments.should == [
      'Name: 1 beacon', 
      'Approximately the 32nd-most common oscillator.',
      'www.conwaylife.com/wiki/index.php?title=1_beacon'
    ]
  end

  it 'parses name and meta info correctly' do
    subject.name.should == "1 beacon"
    #subject.description.should == "Approximately the 32nd-most common oscillator."
    #subject.description_url.should == "www.conwaylife.com/wiki/index.php?title=1_beacon"
  end

  it 'loads beacon pattern correctly' do
    find_cell(subject.cells, 1, 1).should be_dead
    find_cell(subject.cells, 2, 1).should be_dead
    find_cell(subject.cells, 3, 1).should be_alive
    find_cell(subject.cells, 4, 1).should be_alive

    find_cell(subject.cells, 1, 2).should be_dead
    find_cell(subject.cells, 2, 2).should be_alive
    find_cell(subject.cells, 3, 2).should be_dead
    find_cell(subject.cells, 4, 2).should be_alive
  end
end
