class Matsermind
  attr_reader :board, :feedback

  def initialize 
    @win_comb = [1, 6, 2, 4] # example
    @feedback = []
    @board = [0, 0, 0, 0]
    p @board
  end

  def update_board(first, second, third, fourth)
    @board = [first, second, third, fourth]
  end

  def win?
    @win_comb == @board
  end

  def feedback
    board.each_with_index do |number, index|
      @win_comb.each_with_index do |duplicate, index1|
        if number == duplicate && index == index1
          @feedback += ["*"]
        elsif number == duplicate && index != index1
          @feedback += ["~"]
        end
      end
    end
    p @feedback.shuffle
  end
end

# example 
game = Matsermind.new
game.board
game.update_board(1, 5, 6, 4)
p game.board
p game.win?
game.feedback # => ["*", "*", "~"] result must be shuffled to make the game even harder!