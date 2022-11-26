class Matsermind
  attr_reader :board, :feedback, :chosen_code

  def initialize 
    @win_comb = [1, 6, 2, 4] # example
    @feedback = []
    @board = [0, 0, 0, 0]
    @included = []
    @a = []
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
          if setup_turns?
            @included += [duplicate]
          end
        elsif number == duplicate && index != index1
          @feedback += ["~"]
          if setup_turns?
            @included += [duplicate]
          end
        end
        
      end
    end
    puts "Feedback: #{@feedback.shuffle}"
  end

  def conditioned?
    @chosen_code.uniq.length == 4 && @chosen_code.all? { |el| el.between?(1, 6)}
  end

  def input_code
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

  def your_turn
    input_code
    update_board(@chosen_code)
    feedback
  end

  def cpu_turn
    update_board(random_input)
    feedback
  end
    
  def setup_turns
    @input = gets.chomp.downcase
    if @input == "m"
      puts "AS a Mastermind, input your secret Code"
      puts "Hint: 4 different numbers (1-6) separated by 'space'"
      @win_comb = input_code
    elsif @input == "c"
      puts "Cpu is making secret code..."
      sleep(2)
      @win_comb = random_input
    end
    def setup_turns?
      if @input == "m" 
        true
      elsif @input == "c"
        false
      end
    end
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
    puts "2- In feedback (*) means the player guessed one right number in it's right position"
    puts "3- (~) means player got one right number but misplaced it"
    puts "4- The feedback elements aren't sorted in proper order, Good-Luck ;)"
    print "----------------"
    print "----------------"
    print "----------------"
    print "----------------"
    print "----------------" "\n"
    puts "Would you like to be the Mastermind or the Code-breaker? (M or C)"
    setup_turns
    if setup_turns? == false
      puts "Okay, Try 4 different numbers (1-6) separated by 'space'"
      12.times do 
        your_turn
        @feedback = []
        if win?
          puts "Code-breaker wins"
          break
        end
        puts "Keep going, til' you guess it right"
      end
      puts"Game Over"

    elsif setup_turns? == true
      12.times do
        puts "Cpu is thinking..."
        sleep(2)
        cpu_turn
        @feedback = []
        
        if win?
          puts "Mastermind wins"
          break
        end
      end
      puts"Game Over"
    end
  end
end
game = Matsermind.new
# game.play