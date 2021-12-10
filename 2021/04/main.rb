require_relative '../helpers'

def test
  """
  7,4,9,5,11,17,23,2,0,14,21,24,10,16,13,6,15,25,12,22,18,20,8,19,3,26,1

  22 13 17 11  0
   8  2 23  4 24
  21  9 14 16  7
   6 10  3 18  5
   1 12 20 15 19
  
   3 15  0  2 22
   9 18 13 17  5
  19  8  7 25 23
  20 11 10 24  4
  14 21 16 12  6
  
  14 21 17 24  4
  10 16 15  9 19
  18  8 23 26 20
  22 11 13  6  5
   2  0 12  3  7
  """
end

class Board
  def initialize(board)
    @board = board.map { |row| row.split(" ") }.select { |row| row.length == 5 }
    @old_boards = []
    @mark = 0
    @turns = 0
  end

  def old_boards
    @old_boards
  end

  def turns
    @turns
  end

  def marker
    'X'
  end

  def last_mark
    @mark
  end

  def mark(mark)
    @turns += 1
    @mark = mark
    @old_boards << self.dup
    @board = @board.map { |row| row.map { |c| c.to_i == mark.to_i ? marker : c } }
  end

  def score
    (
      rows.map { |x| x.map(&:to_i).sum }.sum
    ) * @mark
  end

  def winner?
    rows.any? { |row| row.all? { |cell| cell == marker}} ||
    cols.any? { |col| col.all? { |cell| cell == marker}}
  end

  def rows
    @board
  end

  def cols
    rows.transpose
  end

  def to_s
    puts
    puts "Last Number: #{@mark} | Score: #{winner? ? score: "N/A"} | Turns: #{@turns}"
    rows.each do |r|
      puts r.map { |c| c == marker ?  c.rjust(3, ' ').red : c.rjust(3, ' ').green }.join(" ")
    end
    puts ''
  end
end


puzzle '4.1', input: :raw do |input|
  chunks = input.split("\n\n")
  moves  = chunks.first.split(',').map(&:to_i)
  boards = chunks[1..-1].map { |chunk| Board.new(chunk.split("\n")) }

  moves.each do |move|
    boards.each do |board|
      if board.winner?
        next
      end
      board.mark(move)
    end
  end
  boards.sort_by(&:turns).each do |board|
    puts board
  end
end
