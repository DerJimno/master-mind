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

  def play
    puts "Welcome to Mastermind"
    print "----------------"
    print "----------------"
    print "--{"
    print " Rules "
    print "}------------" 
    print "----------------"
    print "---------""\n"
    puts "1- There are 6 possibilities in which only 4/6 numbers can occur(No Duplicates)"
    puts "2- In feedback (*) means you guessed one right number in it's right position"
    puts "3- (~) means you got one right number but misplaced it"
    puts "4- The feedback elements aren't sorted in proper order, Good-Luck ;)"
    print "----------------"
    print "----------------"
    print "----------------"
    print "----------------"
    print "----------------" "\n"
    puts "Try 4 different numbers (1-6) separated by 'space'"
    12.times do 
      turn
      @feedback = []
      if win?
        puts "Code-breaker wins"
        break
      end
      puts "Keep going, til' you guess it right"
    end
    puts"Game Over"
  end
end

# example 
game = Matsermind.new
game.play