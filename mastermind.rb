module Colors
  COLORS = ["red", "orange", "yellow", "green", "blue", "violet"]
end

module Combinations
  @@computer_combo = []
  @@human_combo = []
  @@computer_correct_guesses = [0, 1, 2, 3]
  @@reuse_color = []
end

class Computer
  include Colors
  include Combinations
  
  def new_combo
    4.times do 
      @@computer_combo.push(COLORS[rand(0..5)])
    end  
    return @@computer_combo
  end
end

class MasterMind 
  include Colors
  include Combinations

  def game_intro
    print "WELCOME TO MASTERMIND!\n"
    puts "Press [1] if you want to be the CodeBreaker."
    puts "Press [2] if you want to be the CodeMaker."
    selection = gets.chomp
    puts "\n"
    game_selector(selection)
  end

  def game_selector(selection)
    if selection.to_i == 1
      puts "                    CODEBREAKER"
      print "      The computer will generate a combination choosing from up to 6 colors\n
      COLORS: [red, orange, yellow, green, blue, violet]\n
      Example Combination: [red, green, violet, orange]\n
      Your job is to guess the combination in order correctly using up to 12 guesses.
      If you guess a correct color but in the wrong spot, 'almost!' will appear in the combo.
      If you guess a correct color in the exact spot, 'direct hit!' will appear in the combo.
      If you don't guess anything correctly, 'no match' will appear in the combo.\n
      Ready to play? Y/N\n"
      response = gets.chomp.upcase
        if response == "Y"
          code_breaker_start
        else 
          game_intro
        end
    elsif selection.to_i == 2
      puts "                    CODEMAKER"
      print "      You will generate a 4 digit combination choosing from up to 6 colors\n
      COLORS: [red, orange, yellow, green, blue, violet]\n
      Example Combination: [red, green, violet, orange]\n
      The computer will then try and guess what your combination is.
      If the computer can't guess your combination in 12 tries you win!
      Careful.... the computer is smart.
      Ready to play? Y/N\n"
      response = gets.chomp.upcase
        if response == "Y"
          code_maker_start
        else
          game_intro
        end
    end   
  end

  def code_breaker_start 
    computer = Computer.new
    computer.new_combo
    puts 
    "The computer has chosen it's combination! Time to crack it!"
    guess_combo
  end
  
  def guess_combo
    guesses = 12
    12.times do
    print "Guess a combination!\n"
    print "Colors = #{COLORS}\n"
    print "Color 1:"
    color1 = gets.chomp.downcase
    print "Color 2:"
    color2 = gets.chomp.downcase
    print "Color 3:"
    color3 = gets.chomp.downcase
    print "Color 4:"
    color4 = gets.chomp.downcase
    human_guess = [color1, color2, color3, color4]
    guesses -= 1
    puts "\n"
    check_combo(human_guess)
    puts "Guesses remaining: #{guesses}"
    puts "\n"
    end
    puts "Game Over! The computer won."
    exit!
  end

  def check_combo(human_guess)
    i = 0

    if human_guess == @@computer_combo
      puts "YOU WIN!!!!"
      exit!
    end

    until i == 4
      if human_guess[i] == @@computer_combo[i]
        human_guess[i] = "direct hit!"
        i += 1
      elsif @@computer_combo.include?(human_guess[i])
        human_guess[i] = "almost."
        i += 1
      else 
        human_guess[i] = "no match"
        i += 1
      end
    end
    p human_guess
    puts "\n"
  end

  def code_maker_start
    print "Create a combination!"
    print "You can use repeat colors.\n"
    print "Colors = #{COLORS}\n"
    print "Color 1:"
    color1 = gets.chomp.downcase
    print "Color 2:"
    color2 = gets.chomp.downcase
    print "Color 3:"
    color3 = gets.chomp.downcase
    print "Color 4:"
    color4 = gets.chomp.downcase
    puts "\n"
    @@human_combo = [color1, color2, color3, color4]
    p @@human_combo
    puts "Press [1] to let the computer start guessing!"
    input = gets.chomp
    if input.to_i == 1
        computer_guess_combo
    end
  end

  def computer_guess_combo
    guesses = 12
    12.times do
    color1 = COLORS[rand(0..5)]
    color2 = COLORS[rand(0..5)]
    color3 = COLORS[rand(0..5)]
    color4 = COLORS[rand(0..5)]
    computer_guess = [color1, color2, color3, color4]
    verify_color(computer_guess)
    reuse_colors(computer_guess)
    guesses -= 1
    puts "\n"
    computer_check_combo(computer_guess)
    puts "Guesses remaining: #{guesses}"
    puts "\n"
    @@reuse_color = []
    sleep 1
    end
    puts "You Win!"
    exit!
  end

  def computer_check_combo(computer_guess)
    i = 0
    until i == 4
      if computer_guess == @@human_combo
        puts "The Computer Won!"
        p computer_guess
        exit!
      elsif @@computer_correct_guesses == @@human_combo
        p @@computer_correct_guesses
        puts "The Computer Won!"
        exit!
      elsif computer_guess[i] == @@human_combo[i]
        @@computer_correct_guesses[i] = @@human_combo[i]
        computer_guess[i] = @@human_combo[i]
        i += 1
      elsif @@human_combo.include?(computer_guess[i]) && computer_guess[i] != @@human_combo[i]
        @@reuse_color.push(computer_guess[i])
        i += 1
      else
        i += 1 
      end
    end
    p computer_guess
  end

  def verify_color(computer_guess)
    @@computer_correct_guesses.each_with_index { |color, idx| computer_guess[idx] = color if COLORS.include?(color)}
  end

  def reuse_colors(computer_guess)
    @@computer_correct_guesses.each_with_index do |color, idx|
      if computer_guess.include?(color) && computer_guess[idx] != color
        computer_guess[idx] = @@reuse_color[rand(0..@@reuse_color.length)]
      else
        return
      end
    end
  end
 
end

game = MasterMind.new
game.game_intro