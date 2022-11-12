class Matsermind
  attr_reader :board

  def initialize 
    @win_comb = [1, 6, 2, 4] # example
    @board = [0, 0, 0, 0]
    p @board
  end
end