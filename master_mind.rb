class Matsermind
  attr_reader :board, :feedback, :chosen_code

  def initialize 
    @win_comb = [1, 6, 2, 4] # example
    @feedback = []
    @board = [0, 0, 0, 0]
  end

  def update_board(code)
    @board = code
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
    puts "Feedback: #{@feedback.shuffle}"
  end

  def conditioned?
    @chosen_code.uniq.length == 4 && @chosen_code.all? { |el| el.between?(1, 6)}
  end

  def input
    input = gets.chomp
    @chosen_code = input.split(" ").map(&:to_i)
    conditioned?
    until conditioned?
      puts "----Invalid input----"
      puts "Try 4 different numbers between 1-6"
      input = gets.chomp
      @chosen_code = input.split(" ").map(&:to_i)
      conditioned?
    end
    @chosen_code
  end

  def turn
    input
    update_board(@chosen_code)
    feedback
  end
end

# example 
game = Matsermind.new