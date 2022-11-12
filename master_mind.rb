class Matsermind
  attr_reader :board

  def initialize 
    @win_comb = [1, 6, 2, 4] # example
    @board = [0, 0, 0, 0]
    p @board
  end

  def update_board(first, second, third, fourth)
    @board = [first, second, third, fourth]
  end

  def win?
    @win_comb == @board
  end

end